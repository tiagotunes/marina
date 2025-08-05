import 'package:flutter/material.dart';
import 'package:marina/common/utils/constants.dart';
import 'package:marina/common/utils/image_res.dart';
import 'package:marina/common/widgets/primary_button.dart';
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
  final currentPage = controller.hasClients
      ? controller.page?.round() ?? 0
      : controller.initialPage;

  return primaryElevatedButton(
    func: () {
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
    context: context,
    center: currentPage < 2 ? Text('Continuar') : Text('Começar'),
    right: currentPage < 2 ? null : Icon(Icons.play_arrow_rounded),
  );
}
