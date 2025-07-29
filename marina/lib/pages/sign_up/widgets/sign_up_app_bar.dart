import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

AppBar signUpAppBar() {
  return AppBar(
    title: Text("Registar"),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: Container(color: Colours.lightThemeGray1Colour, height: 1),
    ),
  );
}
