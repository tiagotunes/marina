import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

Widget marinaDotsIndicator(double index, int count) {
  return DotsIndicator(
    position: index,
    dotsCount: count,
    mainAxisAlignment: MainAxisAlignment.center,
    decorator: DotsDecorator(
      size: const Size.square(9.0),
      activeSize: const Size(24, 8),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5),
      ),
      activeColor: Colours.lightThemePrimaryColour,
    ),
  );
}
