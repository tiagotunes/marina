import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

PreferredSizeWidget marinaAppBar({
  IconData icon = Icons.error_outline_sharp,
  String title = "<title>",
}) {
  return AppBar(
    leading: Icon(icon),
    title: Text(title),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: Container(color: Colours.lightThemeGray1Colour, height: 1),
    ),
  );
}
