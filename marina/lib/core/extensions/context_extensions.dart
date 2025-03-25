import 'package:flutter/material.dart';
import 'package:marina/core/common/singletons/cache.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);
  double get height => size.height;
  double get width => size.width;

  bool get isDarkMode {
    return switch (Cache.instance.themeModeNotifier.value) {
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(this) == Brightness.dark,
      ThemeMode.dark => true,
      _ => false,
    };
  }

  bool get isLightMode => !isDarkMode;
}
