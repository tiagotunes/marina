import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/about/view/about.dart';
import 'package:marina/features/application/provider/bottom_nav_bar_notifier.dart';
import 'package:marina/features/home/view/home.dart';
import 'package:marina/features/profile/view/profile.dart';
import 'package:marina/features/settings/view/settings.dart';

Widget applcationScreens(WidgetRef ref) {
  int index = ref.watch(bottomNavBarNotifierProvider);

  List<Widget> screens = [Home(), Profile(), Settings(), About()];

  return screens[index];
}
