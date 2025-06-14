import 'package:flutter/widgets.dart';

abstract class TextStyles {
  static const TextStyle heading0 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.71, // 24px
  );
}
