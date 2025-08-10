import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

class TaskPage1 extends StatefulWidget {
  const TaskPage1({super.key});

  @override
  State<TaskPage1> createState() => _TaskPage1State();
}

class _TaskPage1State extends State<TaskPage1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(decoration: taskPageDecoration()),
    );
  }
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
