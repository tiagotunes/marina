import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/loader.dart';
import 'package:marina/common/widgets/primary_button.dart';
import 'package:marina/features/home/provider/home_controller.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar_tag.dart';

Widget homeMenuBar(BuildContext context, WidgetRef ref) {
  final loader = ref.watch(globalLoaderProvider);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          homeMenuBarTag(text: "Todas", selected: true),
          SizedBox(width: 8),
          homeMenuBarTag(text: "Abertas", selected: false),
          SizedBox(width: 8),
          homeMenuBarTag(text: "Fechadas", selected: false),
        ],
      ),
      primaryElevatedButton(
        context: context,
        func: () async {
          final userProfileAsync = await ref.read(
            homeUserProfileProvider.future,
          );
          ref
              .read(userTasksNotifierProvider(userProfileAsync.id!).notifier)
              .addTask();
        },
        center: loader ? marinaLoader() : Icon(Icons.add_rounded),
      ),
    ],
  );
}
