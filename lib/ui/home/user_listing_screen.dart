import 'dart:io';

import 'package:flutter/material.dart';
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
            return Card(
              elevation: 3,
              child: ListTile(
                selected: _userNames[index].isSelected,
                selectedTileColor: Color(0xff003664),
                dense: true,
                onTap: () {
                  _onListTileTap(index);
                },
                leading: CircleAvatar(
                    backgroundColor: _userNames[index].isSelected
                        ? Colors.white
                        : Color(0xff003664),
                    child: Text(
                      _userNames[index].name!.substring(0, 1),
                      style: TextStyle(
                          color: _userNames[index].isSelected
                              ? Color(0xff003664)
                              : Colors.white),
                    )),
                title: Text(_userNames[index].name!,
                    style: TextStyle(
                        color: _userNames[index].isSelected
                            ? Colors.white
                            : Color(0xff003664))),
                subtitle: Text(_userNames[index].email!,
                    style: TextStyle(color: Colors.grey)),
              ),
            );
          }));

  Widget _selectedUserListingView(BuildContext context) => (_selectedNames
          .isNotEmpty)
      ? Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(offset: Offset(0, -3), blurRadius: 5, color: Colors.grey)
          ]),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              itemCount: _selectedNames.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                    child: Text(
                        "${"${_selectedNames[index]}"}${index == _selectedNames.length - 1 ? "" : " , "}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)));
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
