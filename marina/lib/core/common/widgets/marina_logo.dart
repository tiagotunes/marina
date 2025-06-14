import 'package:flutter/widgets.dart';
import 'package:marina/core/extensions/text_style_extensions.dart';
import 'package:marina/core/res/styles/colours.dart';
import 'package:marina/core/res/styles/text.dart';

class MarinaLogo extends StatelessWidget {
  const MarinaLogo({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'MAR',
        style: style ?? TextStyles.heading0.secondary,
        children: [
          TextSpan(
            text: 'INA',
            style: TextStyle(color: Colours.lightThemePrimaryColour),
          ),
        ],
      ),
    );
  }
}
