import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

Widget marinaLoader({double? height = 16, double? width = 16}) {
  return SizedBox(
    height: height,
    width: width,
    child: CircularProgressIndicator(
      strokeWidth: 4,
      color: Colours.lightThemePrimaryColour,
      backgroundColor: Colours.lightThemeWhiteColour,
    ),
  );
}
