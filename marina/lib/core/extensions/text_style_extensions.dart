import 'package:flutter/widgets.dart';
import 'package:marina/core/res/styles/colours.dart';

extension TextStyleExt on TextStyle {
  TextStyle get secondary => copyWith(color: Colours.lightThemeSecondaryColour);

  TextStyle adaptiveColour(BuildContext context) =>
      copyWith(color: Colours.classicAdaptiveTextColour(context));
}
