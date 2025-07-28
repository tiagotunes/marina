import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

Widget onBoardingPage(
  PageController pageController, {
  String imgPath = "assets/images/logo.png",
  String title = "",
  String subtitle = "",
}) {
  return Column(
    children: [
      Image.asset(imgPath, fit: BoxFit.fitWidth),
      Text(title, style: TextStyle(fontSize: 24)),
      Text(subtitle, style: TextStyle(fontSize: 16)),
      _nextButton(pageController),
    ],
  );
}

Widget _nextButton(PageController controller) {
  return GestureDetector(
    onTap: () {
      if (controller.page!.toInt() < 3) {
        controller.animateToPage(
          controller.page!.toInt() + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    },
    child: Container(
      width: 325,
      height: 50,
      margin: EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        color: Colours.lightThemePrimaryColour,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text('Continuar', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
