import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

Widget primaryElevatedButton({
  double? width,
  double? height,
  VoidCallback? func,
  required BuildContext context,
  Widget? left,
  required Widget center,
  Widget? right,
}) {
  List<Widget> children = [];
  if (left != null) {
    children.add(left);
    children.add(SizedBox(width: 8));
  }
  children.add(center);
  if (right != null) {
    children.add(SizedBox(width: 8));
    children.add(right);
  }

  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.lightThemePrimaryColour,
        elevation: 0,
        foregroundColor: Colours.lightThemeWhiteColour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    ),
  );
}
