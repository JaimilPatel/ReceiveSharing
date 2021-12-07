import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receivesharing/constants/file_constants.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';
import 'package:receivesharing/ui/sharing/sharing_media_preview_screen.dart';

extension ScaffoldExtension on Widget {
  Scaffold generalScaffold(
      {BuildContext? context,
      String? appTitle,
      bool isBack = true,
      bool isShowFab = false,
      List<UserDetailModel>? userList,
      List<File>? files,
      String? sharedText}) {
    return Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            shadowColor: Color(0x4D202020),
            backgroundColor: Color(0xff003664),
            brightness: Brightness.dark,
            elevation: 4,
            title: Text(appTitle!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            leading: (isBack)
                ? IconButton(
                    icon: Image.asset(FileConstants.icBack, scale: 3.0),
                    onPressed: () {
                      Navigator.of(context!).pop();
                    },
                  )
                : SizedBox(),
            centerTitle: true),
        body: SafeArea(
          child: this,
        ),
        floatingActionButton: isShowFab
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FloatingActionButton(
                    backgroundColor: Color(0xff003664),
                    onPressed: () {
                      List<UserDetailModel> selectedUsers = [];
                      for (var user in userList!) {
                        if (user.isSelected) {
                          selectedUsers.add(user);
                        }
                      }
                      Navigator.of(context!).push(MaterialPageRoute(
                          builder: (context) => SharingMediaPreviewScreen(
                              files: files,
                              userList: selectedUsers,
                              text: sharedText ?? "")));
                    },
                    child: Image.asset(
                      FileConstants.icShareMedia,
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    )),
              )
            : SizedBox());
  }
}
