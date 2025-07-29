import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

AppBar signInAppBar() {
  return AppBar(
    title: Text("Inciar sessão"),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: Container(color: Colours.lightThemeGray1Colour, height: 1),
    ),
  );
}
