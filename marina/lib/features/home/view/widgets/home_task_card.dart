import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/routes/routes_names.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/main.dart';

Widget homeTaskCard(WidgetRef ref, String userId, UserTask task) {
  return ListTile(
    onTap: () {
      navKey.currentState?.pushNamed(RoutesNames.TASK, arguments: task.id).then(
        (_) {
          ref.read(userTasksNotifierProvider(userId).notifier).refresh();
        },
      );
    },
    title: Text(task.docTitle ?? ""),
    titleTextStyle: task.read!
        ? TextStyles.body1
        : TextStyles.body1.copyWith(color: Colours.lightThemeWhiteColour),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          task.status == "submit"
              ? Icons.file_download_done_rounded
              : task.read!
              ? Icons.file_open_outlined
              : Icons.file_open_rounded,
        ),
        // task.status == "submit" ? Text(task.status!.toUpperCase()) : SizedBox(),
      ],
    ),
    iconColor: task.read ?? false
        ? Colours.lightThemePrimaryColour
        : Colours.lightThemeWhiteColour,
    tileColor: task.status == "submit"
        ? Colours.lightThemePrimaryColour.withValues(alpha: 0.20)
        : task.read ?? false
        ? Colours.lightThemeWhiteColour
        : Colours.lightThemePrimaryColour,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(8),
      side: BorderSide(color: Colours.lightThemePrimaryColour, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
}
