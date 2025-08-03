import 'package:flutter/material.dart';
import 'package:marina/common/utils/constants.dart';
import 'package:marina/common/utils/image_res.dart';
import 'package:marina/global.dart';

Widget onBoardingPage(
  BuildContext context,
  PageController pageController, {
  String imgPath = ImageRes.logo,
  String title = "",
  String subtitle = "",
}) {
  return Column(
    children: [
      Image.asset(imgPath, fit: BoxFit.fitWidth),
      Text(title, style: TextStyle(fontSize: 24)),
      Text(subtitle, style: TextStyle(fontSize: 16)),
      SizedBox(height: 24),
      _nextButton(context, pageController),
    ],
  );
}

Widget _nextButton(BuildContext context, PageController controller) {
  return ElevatedButton(
    onPressed: () {
      if (controller.page!.toInt() < 2) {
        controller.animateToPage(
          controller.page!.toInt() + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      } else {
        Global.storageService.setBool(Constants.STORAGE_USER_FIRST_TIME, true);
        Navigator.pushNamed(context, '/signIn');
      }
    },
    child: SizedBox(
      width: 325,
      height: 50,
      child: Center(child: Text('Continuar')),
    ),
  );
}
