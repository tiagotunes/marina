import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/home/view/widgets/bottom_nav_bar.dart';
import 'package:marina/features/home/view/widgets/home_screens.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: homeScreens(ref),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: bottomNavBar(ref),
      ),
    );
  }
}
