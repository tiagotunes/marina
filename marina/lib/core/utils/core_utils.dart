import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:marina/core/extensions/context_extensions.dart';

abstract class CoreUtils {
  const CoreUtils();

  static void postFrammeCall(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static Color adaptiveColour(
    BuildContext context, {
    required Color lightModeColour,
    required Color darkModeColour,
  }) {
    return context.isDarkMode ? darkModeColour : lightModeColour;
  }
}
