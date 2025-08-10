import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/dots_indicator.dart';
import 'package:marina/common/widgets/loader.dart';
import 'package:marina/features/task/provider/task_notifier.dart';
import 'package:marina/features/task/provider/task_page_notifier.dart';
import 'package:marina/features/task/view/widget/task_page.dart';

class Task extends ConsumerWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskId = ModalRoute.of(context)!.settings.arguments as String;
    final PageController pageController = PageController();
    final index = ref.watch(indexDotProvider);
    final taskAsync = ref.watch(taskNotifierProvider(taskId));

    return Scaffold(
      appBar: marinaAppBar(actions: [Icon(Icons.menu_rounded)]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 36),
        child: Column(
          children: [
            Expanded(
              child: taskAsync.when(
                data: (task) => PageView(
                  onPageChanged: (value) {
                    ref.read(indexDotProvider.notifier).changeIndex(value);
                  },
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    TaskPage1(
                      title: task.docId!.title!,
                      text: task.docId!.text!,
                    ),
                    TaskPage1(
                      title: task.docId!.title!,
                      text: task.docId!.text!,
                    ),
                    TaskPage1(
                      title: task.docId!.title!,
                      text: task.docId!.text!,
                    ),
                  ],
                ),
                error: (e, st) => Text('Error loading task: $e'),
                loading: () => Center(child: marinaLoader()),
              ),
            ),
            SizedBox(height: 16),
            marinaDotsIndicator(index.toDouble(), 3),
          ],
        ),
      ),
    );
  }
}
