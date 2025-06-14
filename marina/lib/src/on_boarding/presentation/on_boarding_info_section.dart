import 'package:flutter/widgets.dart';
import 'package:marina/core/res/media.dart';

class OnBoardingInfoSection extends StatelessWidget {
  const OnBoardingInfoSection.first({super.key}) : first = true;
  const OnBoardingInfoSection.second({super.key}) : first = false;

  final bool first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Media.logo),
          Text(switch (first) {
            true => 'First',
            _ => 'Second',
          }),
        ],
      ),
    );
  }
}
