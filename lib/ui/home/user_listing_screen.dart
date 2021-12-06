import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receivesharing/extension/scaffold_extension.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';

class UserListingScreen extends StatefulWidget {
  final List<File> files;
  UserListingScreen({required this.files});
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: _userNames.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  selected: _userNames[index].isSelected,
                  selectedTileColor: Color(0xffC3EAFA),
                  dense: true,
                  onTap: () {
                    _onListTileTap(index);
                  },
                  leading: CircleAvatar(
                      backgroundColor: Color(0xff003664),
                      child: Text(
                        _userNames[index].name!.substring(0, 1),
                        style: TextStyle(color: Colors.white),
                      )),
                  title: Text(_userNames[index].name!),
                  subtitle: Text(_userNames[index].email!),
                ),
              );
            })
        .generalScaffold(
            context: context,
            appTitle: "Users",
            isShowFab: _isSelected,
            files: widget.files,
            userList: _userNames);
  }

  void _onListTileTap(int index) {
    setState(() {
      _userNames[index].isSelected = !_userNames[index].isSelected;
      List<String?> selectedNames = [];
      for (var names in _userNames) {
        if (names.isSelected) {
          if (!selectedNames.contains(names.name)) {
            selectedNames.add(names.name);
          }
        } else {
          selectedNames.remove(names.name);
        }
      }
      _isSelected = selectedNames.isNotEmpty;
    });
  }
}
