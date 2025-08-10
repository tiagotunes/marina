import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/utils/image_res.dart';
import 'package:marina/common/widgets/dots_indicator.dart';
import 'package:marina/features/on_boarding/provider/on_boarding_notifier.dart';
import 'package:marina/features/on_boarding/view/widgets/on_boarding_page.dart';

class OnBoarding extends ConsumerWidget {
  OnBoarding({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexDotProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView(
              onPageChanged: (value) {
                ref.read(indexDotProvider.notifier).changeIndex(value);
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                OnBoardingPage(
                  context: context,
                  pageController: _pageController,
                  title: "ON_BOARDING ${index + 1}",
                  subtitle: "ObBoarding Subtitle ${index + 1}",
                  imgPath: ImageRes.logo,
                ),
                OnBoardingPage(
                  context: context,
                  pageController: _pageController,
                  title: "ON_BOARDING ${index + 1}",
                  subtitle: "ObBoarding Subtitle ${index + 1}",
                  imgPath: ImageRes.logo,
                ),
                OnBoardingPage(
                  context: context,
                  pageController: _pageController,
                  title: "ON_BOARDING ${index + 1}",
                  subtitle: "ObBoarding Subtitle ${index + 1}",
                  imgPath: ImageRes.logo,
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              child: marinaDotsIndicator(index.toDouble(), 3),
            ),
          ],
        ),
      ),
    );
  }
}
