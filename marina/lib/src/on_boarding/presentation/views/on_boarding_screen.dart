import 'package:flutter/material.dart';
import 'package:marina/src/on_boarding/presentation/on_boarding_info_section.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    debugPrint('OnBoardign build');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PageView(
            allowImplicitScrolling: true,
            controller: pageController,
            children: const [
              OnBoardingInfoSection.first(),
              OnBoardingInfoSection.second(),
            ],
          ),
        ),
      ),
    );
  }
}
