import 'package:flutter/material.dart';
import 'package:receivesharing/constants/color_constants.dart';
import 'package:receivesharing/constants/dimens_constants.dart';
import 'package:receivesharing/constants/font_size_constants.dart';

class EmptyView extends StatelessWidget {
  final String topLine;
  final String bottomLine;

  const EmptyView({required this.topLine, required this.bottomLine});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionConstants.horizontalPadding34),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              _getText(text: topLine),
              _getText(text: bottomLine)
            ])));
  }

  Widget _getText({String? text}) {
    return Text(text!,
        style: TextStyle(
            color: ColorConstants.greyColor,
            fontSize: FontSizeWeightConstants.fontSize20));
  }
}
