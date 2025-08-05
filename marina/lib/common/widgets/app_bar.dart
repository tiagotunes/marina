import 'package:flutter/material.dart';

PreferredSizeWidget marinaAppBar({
  List<Widget>? actions,
  bool? autoImplyLeading,
  Widget title = const Text('<title>'),
}) {
  return AppBar(
    actions: actions,
    automaticallyImplyLeading: autoImplyLeading ?? true,
    title: title,
  );
}
