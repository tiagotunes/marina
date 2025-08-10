import 'package:flutter/material.dart';

PreferredSizeWidget marinaAppBar({
  List<Widget>? actions,
  bool autoImplyLeading = true,
  Widget title = const Text(''),
}) {
  return AppBar(
    actions: actions,
    actionsPadding: EdgeInsets.only(right: 16),
    automaticallyImplyLeading: autoImplyLeading,
    title: title,
  );
}
