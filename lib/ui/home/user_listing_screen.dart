import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receivesharing/constants/color_constants.dart';
import 'package:receivesharing/constants/dimens_constants.dart';
import 'package:receivesharing/constants/font_size_constants.dart';
import 'package:receivesharing/extension/scaffold_extension.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';

class UserListingScreen extends StatefulWidget {
  final List<File>? files;
  final String? text;
  UserListingScreen({this.files, this.text = ""});
  @override
  _UserListingScreenState createState() => _UserListingScreenState();
}

class _UserListingScreenState extends State<UserListingScreen> {
  List<UserDetailModel> _userNames = [
    UserDetailModel(
        name: "Harsh", email: "harsh.dev@gmail.com", isSelected: false),
    UserDetailModel(
        name: "Jaimil", email: "jaimil.dev@gmail.com", isSelected: false),
    UserDetailModel(
        name: "Piyush", email: "piyush.dev@gmail.com", isSelected: false),
    UserDetailModel(
        name: "Niket", email: "niket.dev@gmail.com", isSelected: false),
    UserDetailModel(
        name: "Shailin", email: "shailin.dev@gmail.com", isSelected: false),
    UserDetailModel(
        name: "Nishat", email: "nishat.dev@gmail.com", isSelected: false),
  ];
  bool _isSelected = false;
  List<String?> _selectedNames = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_userListingView(context), _selectedUserListingView(context)],
    ).generalScaffold(
        context: context,
        appTitle: "Users",
        isShowFab: _isSelected,
        files: widget.files,
        userList: _userNames,
        sharedText: widget.text);
  }

  Widget _userListingView(BuildContext context) => Expanded(
      child: ListView.builder(
          itemCount: _userNames.length,
          itemBuilder: (context, index) {
            return _userListItemView(context, index);
          }));

  Widget _userListItemView(BuildContext context, int index) => Card(
        elevation: 3,
        child: ListTile(
          selected: _userNames[index].isSelected,
          selectedTileColor: ColorConstants.primaryColor,
          dense: true,
          onTap: () {
            _onListTileTap(index);
          },
          leading: _leadingCircularView(index),
          title: _titleView(index),
          subtitle: _subTitleView(index),
        ),
      );

  Widget _leadingCircularView(int index) => CircleAvatar(
      backgroundColor: _userNames[index].isSelected
          ? ColorConstants.whiteColor
          : ColorConstants.primaryColor,
      child: Text(
        _userNames[index].name!.substring(0, 1),
        style: TextStyle(
            color: _userNames[index].isSelected
                ? ColorConstants.primaryColor
                : ColorConstants.whiteColor),
      ));

  Widget _titleView(int index) => Text(_userNames[index].name!,
      style: TextStyle(
          color: _userNames[index].isSelected
              ? ColorConstants.whiteColor
              : ColorConstants.primaryColor));

  Widget _subTitleView(int index) => Text(_userNames[index].email!,
      style: TextStyle(color: ColorConstants.greyColor));

  Widget _selectedUserListingView(BuildContext context) => (_selectedNames
          .isNotEmpty)
      ? Container(
          height: DimensionConstants.containerHeight50,
          decoration:
              BoxDecoration(color: ColorConstants.whiteColor, boxShadow: [
            BoxShadow(offset: Offset(0, -3), blurRadius: 5, color: Colors.grey)
          ]),
          padding: EdgeInsets.symmetric(
              horizontal: DimensionConstants.horizontalPadding10),
          child: ListView.builder(
              itemCount: _selectedNames.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                    child: Text(
                        "${"${_selectedNames[index]}"}${index == _selectedNames.length - 1 ? "" : " , "}",
                        style: TextStyle(
                            fontSize: FontSizeWeightConstants.fontSize14,
                            fontWeight:
                                FontSizeWeightConstants.fontWeight500)));
              }))
      : SizedBox();

  void _onListTileTap(int index) {
    setState(() {
      _userNames[index].isSelected = !_userNames[index].isSelected;
      for (var names in _userNames) {
        if (names.isSelected) {
          if (!_selectedNames.contains(names.name)) {
            _selectedNames.add(names.name);
          }
        } else {
          _selectedNames.remove(names.name);
        }
      }
      _isSelected = _selectedNames.isNotEmpty;
    });
  }
}
