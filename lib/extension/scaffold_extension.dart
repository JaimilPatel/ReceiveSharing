import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receivesharing/constants/color_constants.dart';
import 'package:receivesharing/constants/dimens_constants.dart';
import 'package:receivesharing/constants/file_constants.dart';
import 'package:receivesharing/constants/font_size_constants.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';
import 'package:receivesharing/ui/sharing/sharing_media_preview_screen.dart';

extension ScaffoldExtension on Widget {
  //General Scaffold For All Screens
  Scaffold generalScaffold(
      {BuildContext? context,
      String? appTitle,
      bool isBack = true,
      bool isShowFab = false,
      List<UserDetailModel>? userList,
      List<File>? files,
      String? sharedText}) {
    return Scaffold(
        appBar: _generalAppBar(context, appTitle, isBack),
        body: SafeArea(
          child: this,
        ),
        floatingActionButton: isShowFab
            ? _fabButton(userList, sharedText, context, files)
            : SizedBox());
  }

  AppBar _generalAppBar(BuildContext? context, String? appTitle, bool isBack) =>
      AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(DimensionConstants.circular20),
                  bottomRight: Radius.circular(DimensionConstants.circular20))),
          shadowColor: ColorConstants.appBarShadowColor,
          backgroundColor: ColorConstants.primaryColor,
          brightness: Brightness.dark,
          elevation: 4,
          title: Text(appTitle!,
              style: TextStyle(
                  color: ColorConstants.whiteColor,
                  fontSize: FontSizeWeightConstants.fontSize24,
                  fontWeight: FontSizeWeightConstants.fontWeightBold)),
          leading: (isBack)
              ? IconButton(
                  icon: Image.asset(FileConstants.icBack, scale: 3.0),
                  onPressed: () {
                    Navigator.of(context!).pop();
                  },
                )
              : SizedBox(),
          centerTitle: true);

  Widget _fabButton(
    List<UserDetailModel>? userList,
    String? sharedText,
    BuildContext? context,
    List<File>? files,
  ) =>
      Padding(
        padding:
            const EdgeInsets.only(bottom: DimensionConstants.bottomPadding8),
        child: FloatingActionButton(
            backgroundColor: ColorConstants.primaryColor,
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
              height: DimensionConstants.imageHeight30,
              width: DimensionConstants.imageWidth30,
              color: ColorConstants.whiteColor,
            )),
      );
}
