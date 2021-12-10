import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:receivesharing/constants/app_constants.dart';
import 'package:receivesharing/constants/color_constants.dart';
import 'package:receivesharing/constants/dimens_constants.dart';
import 'package:receivesharing/constants/font_size_constants.dart';
import 'package:receivesharing/extension/scaffold_extension.dart';
import 'package:receivesharing/ui/home/user_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      listenShareMediaFiles(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstants.horizontalPadding10),
        child: Text("Receive Sharing Files And Send To Multiple Users...",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: FontSizeWeightConstants.fontSize20,
                color: ColorConstants.greyColor)),
      ),
    ).generalScaffold(
        context: context,
        appTitle: "Receive Sharing Files",
        isBack: false,
        files: [],
        userList: []);
  }

  //All listeners to listen Sharing media files & text
  void listenShareMediaFiles(BuildContext context) {
    // For sharing images coming from outside the app
    // while the app is in the memory
    ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
      navigateToShareMedia(context, value);
    }, onError: (err) {
      debugPrint("$err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      navigateToShareMedia(context, value);
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getTextStream().listen((String value) {
      navigateToShareText(context, value);
    }, onError: (err) {
      debugPrint("$err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      navigateToShareText(context, value);
    });
  }

  void navigateToShareMedia(BuildContext context, List<SharedMediaFile> value) {
    if (value.isNotEmpty) {
      var newFiles = <File>[];
      value.forEach((element) {
        newFiles.add(File(
          Platform.isIOS
              ? element.type == SharedMediaType.FILE
                  ? element.path
                      .toString()
                      .replaceAll(AppConstants.replaceableText, "")
                  : element.path
              : element.path,
        ));
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserListingScreen(
                files: newFiles,
                text: "",
              )));
    }
  }

  void navigateToShareText(BuildContext context, String? value) {
    if (value != null && value.toString().isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserListingScreen(
                files: [],
                text: value,
              )));
    }
  }
}
