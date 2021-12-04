import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';
import 'package:receivesharing/ui/sharing/sharing_media_preview_screen.dart';

class UserListingScreen extends StatefulWidget {
  final List<File> files;
  UserListingScreen({required this.files});
  @override
  _UserListingScreenState createState() => _UserListingScreenState();
}

class _UserListingScreenState extends State<UserListingScreen> {
  List<UserDetailModel> _userNames = [
    UserDetailModel(name: "Harsh", email: "harsh123@gmail.com"),
    UserDetailModel(name: "Jaimil", email: "jaimil123@gmail.com"),
    UserDetailModel(name: "Piyush", email: "piyush123@gmail.com"),
    UserDetailModel(name: "Niket", email: "niket123@gmail.com"),
    UserDetailModel(name: "Shailin", email: "shailin123@gmail.com"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _userNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SharingMediaPreviewScreen(files: widget.files)));
              },
              leading: CircleAvatar(
                  child: Text(_userNames[index].name!.substring(0, 1))),
              title: Text(_userNames[index].name!),
              subtitle: Text(_userNames[index].email!),
            );
          }),
    );
  }
}
