import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/home/provider/bottom_nav_bar_notifier.dart';

Widget homeScreens(WidgetRef ref) {
  int index = ref.watch(bottomNavBarNotifierProvider);

  List<Widget> screens = [
    Center(child: Text('HOME')),
    Center(child: Text('PROFILE')),
    Center(child: Text('SETTINGS')),
    Center(child: Text('ABOUT')),
  ];

  return screens[index];
}
