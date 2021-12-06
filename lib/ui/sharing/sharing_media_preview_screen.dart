import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:receivesharing/constants/app_constants.dart';
import 'package:receivesharing/constants/file_constants.dart';
import 'package:receivesharing/extension/scaffold_extension.dart';
import 'package:receivesharing/ui/home/model/user_detail_model.dart';
import 'package:receivesharing/widget/empty_view.dart';

import '../model/media_preview_item.dart';

class SharingMediaPreviewScreen extends StatefulWidget {
  final List<UserDetailModel> userList;
  final List<File> files;
  SharingMediaPreviewScreen({required this.userList, required this.files});
  @override
  _SharingMediaPreviewScreenState createState() =>
      _SharingMediaPreviewScreenState();
}

class _SharingMediaPreviewScreenState extends State<SharingMediaPreviewScreen> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.95, keepPage: false);
  final List<MediaPreviewItem> _galleryItems = [];
  int _initialIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        var i = 0;
        widget.files.forEach((element) {
          _galleryItems.add(MediaPreviewItem(
              id: i,
              resource: element,
              controller: TextEditingController(),
              isSelected: i == 0 ? true : false));
          i++;
        });
      });
    });
  }

  void onPageChanged(int index) {
    setState(() {
      var i = 0;
      _galleryItems.forEach((element) {
        if (i == index) {
          _galleryItems[i].isSelected = true;
        } else {
          _galleryItems[i].isSelected = false;
        }
        i++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _galleryItems.isNotEmpty
        ? Column(
            children: [
              SizedBox(height: 5),
              _fullMediaPreview(context),
              _fileName(context),
              _addCaptionPreview(context),
              _horizontalMediaFilesView(context)
            ],
          ).generalScaffold(
            context: context,
            appTitle: "Send to...",
            files: widget.files,
            userList: widget.userList)
        : EmptyView(
            topLine: "No files are here..",
            bottomLine: "Select files from gallery or file manager.",
          ).generalScaffold(
            context: context,
            appTitle: "Send to...",
            files: widget.files,
            userList: widget.userList);
  }

  Widget _fullMediaPreview(BuildContext context) => Expanded(
          child: PageView(
        controller: _pageController,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          _mediaPreviewChanged(value);
        },
        children: _galleryItems
            .map((e) => AppConstants.imageExtensions
                    .contains(e.resource?.path.split('.').last.toLowerCase())
                ? Image.file(File(e.resource!.path))
                : Image.asset(
                    FileConstants.icFile,
                  ))
            .toList(),
      ));

  void _mediaPreviewChanged(int value) {
    _initialIndex = value;
    setState(() {
      var i = 0;
      _galleryItems.forEach((element) {
        if (i == value) {
          _galleryItems[i].isSelected = true;
        } else {
          _galleryItems[i].isSelected = false;
        }
        i++;
      });
    });
  }

  Widget _fileName(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            "${_galleryItems[_initialIndex].resource!.path.split('/').last}"),
      );

  Widget _addCaptionPreview(BuildContext context) => Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 20.0, top: 10.0),
              child: TextFormField(
                controller: _galleryItems[_initialIndex].controller,
                textInputAction: TextInputAction.done,
                focusNode: FocusNode(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "Add Caption",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    filled: true,
                    fillColor: Color(0xffF5F5F5),
                    counter: Offstage(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                    border: InputBorder.none),
                onFieldSubmitted: (value) {},
                keyboardType: TextInputType.text,
                onTap: () {},
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _onSharingTap(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.asset(
                FileConstants.icSend,
                scale: 2.7,
              ),
            ),
          ),
        ],
      );

  Widget _horizontalMediaFilesView(BuildContext context) =>
      (MediaQuery.of(context).viewInsets.bottom == 0)
          ? Container(
              height: 60,
              margin: const EdgeInsets.only(left: 15.0, bottom: 10, top: 5),
              child: ListView.separated(
                itemCount: _galleryItems.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          var i = 0;
                          _galleryItems.forEach((element) {
                            if (i == index) {
                              _galleryItems[i].isSelected = true;
                            } else {
                              _galleryItems[i].isSelected = false;
                            }
                            i++;
                          });
                        });
                        _pageController.animateToPage(index,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _galleryItems[index].isSelected
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 1.0)),
                          child: AppConstants.imageExtensions.contains(
                                  _galleryItems[index]
                                      .resource
                                      ?.path
                                      .split('.')
                                      .last
                                      .toLowerCase())
                              ? Image.file(
                                  File(_galleryItems[index].resource!.path))
                              : Image.asset(
                                  FileConstants.icFile,
                                )));
                },
                scrollDirection: Axis.horizontal,
              ),
            )
          : SizedBox();

  void _onSharingTap(BuildContext context) {}
}
