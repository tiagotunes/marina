import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/application/provider/bottom_nav_bar_notifier.dart';
import 'package:marina/features/home/view/home.dart';

Widget applcationScreens(WidgetRef ref) {
  int index = ref.watch(bottomNavBarNotifierProvider);

  List<Widget> screens = [
    Home(),
    Center(child: Text('PROFILE')),
    Center(child: Text('SETTINGS')),
    Center(child: Text('ABOUT')),
  ];

  return screens[index];
}
