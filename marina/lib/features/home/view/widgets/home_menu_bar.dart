import 'package:flutter/material.dart';
import 'package:marina/common/widgets/primary_button.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar_tag.dart';

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            homeMenuBarTag(text: "Todas", selected: true),
            SizedBox(width: 8),
            homeMenuBarTag(text: "Abertas", selected: false),
            SizedBox(width: 8),
            homeMenuBarTag(text: "Submetidas", selected: false),
          ],
        ),
        primaryElevatedButton(
          context: context,
          func: () {},
          center: Icon(Icons.add_rounded),
        ),
      ],
    );
  }
}
