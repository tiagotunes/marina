import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/pages/on_boarding/widgets/on_boarding_page.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class OnBoarding extends ConsumerWidget {
  OnBoarding({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView(
              onPageChanged: (value) {
                ref.read(indexProvider.notifier).state = value;
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                onBoardingPage(
                  _pageController,
                  title: "ON_BOARDING 1",
                  subtitle: "ObBoarding Subtitle 1",
                ),
                onBoardingPage(
                  _pageController,
                  title: "ON_BOARDING 2",
                  subtitle: "ObBoarding Subtitle 2",
                ),
                onBoardingPage(
                  _pageController,
                  title: "ON_BOARDING 3",
                  subtitle: "ObBoarding Subtitle 3",
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              child: DotsIndicator(
                position: index.toDouble(),
                dotsCount: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(24, 8),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                  ),
                  activeColor: Colours.lightThemeSecondaryColour,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
