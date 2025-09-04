import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:marina/global.dart';

Widget profilePage() {
  return Container(
    width: double.infinity,
    decoration: taskPageDecoration(),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 32,
          children: [
            profilePageTop(),
            Divider(
              color: Colours.lightThemePrimaryColour.withValues(alpha: 0.25),
              radius: BorderRadius.circular(8),
              thickness: 3,
            ),
            profilePageBottom(),
          ],
        ),
        Center(
          child: Text(
            Global.storageService.getUserProfile().id ?? "-",
            style: TextStyles.tagline.copyWith(
              color: Colours.lightThemeGray2Colour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget profilePageTop() {
  return Column(
    children: [
      Icon(
        Icons.person_pin_rounded,
        color: Colours.lightThemePrimaryColour,
        size: 100,
      ),
      SizedBox(height: 16),
      Text(
        Global.storageService.getUserProfile().name ?? "-",
        style: TextStyles.heading3,
      ),
    ],
  );
}

Widget profilePageBottom() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      spacing: 16,
      children: [
        profileAttribute("Email", Global.storageService.getUserProfile().email),
        profileAttribute(
          "Estado",
          Global.storageService.getUserProfile().status!.toUpperCase(),
        ),
        profileAttribute(
          "Género",
          Global.storageService.getUserProfile().gender,
        ),
      ],
    ),
  );
}

Widget profileAttribute(String label, String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyles.body1.copyWith(color: Colours.lightThemeGray3Colour),
      ),
      Text(value ?? "-", style: TextStyles.body1bold),
    ],
  );
}

BoxDecoration taskPageDecoration() {
  return BoxDecoration(
    color: Colours.lightThemeGray1Colour,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colours.lightThemeBlackColour.withValues(alpha: 0.25),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );
}
