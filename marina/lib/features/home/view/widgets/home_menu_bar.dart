import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colours.lightThemePrimaryColour,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Todos",
            style: TextStyles.tagline.copyWith(
              color: Colours.lightThemeWhiteColour,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colours.lightThemeGray1Colour,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text("Abertos", style: TextStyles.tagline),
        ),
        Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colours.lightThemeGray1Colour,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text("Fechados", style: TextStyles.tagline),
        ),
      ],
    );
  }
}
