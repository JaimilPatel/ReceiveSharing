import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MediaPreviewItem {
  int? id;
  File? resource;
  bool isSelected;
  TextEditingController? controller;
  MediaPreviewItem(
      {this.id, this.resource, this.controller, this.isSelected = false});
}
