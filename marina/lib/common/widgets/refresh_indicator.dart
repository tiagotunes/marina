import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

Widget marinaResfreshIndicator(
  Future<void> Function() onRefresh,
  Widget child,
) {
  return RefreshIndicator(
    onRefresh: onRefresh,
    color: Colours.lightThemePrimaryColour,
    child: child,
  );
}
