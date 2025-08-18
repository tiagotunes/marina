import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/dots_indicator.dart';
import 'package:marina/common/widgets/progress_indicator.dart';
import 'package:marina/features/task/provider/task_notifier.dart';
import 'package:marina/features/task/provider/task_page_notifier.dart';
import 'package:marina/features/task/view/widget/task_page.dart';

class Task extends ConsumerStatefulWidget {
  const Task({super.key});

  @override
  ConsumerState<Task> createState() => _TaskState();
}

class _TaskState extends ConsumerState<Task> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)!.settings.arguments as String;
    final index = ref.watch(indexDotProvider);
    final taskAsync = ref.watch(taskNotifierProvider(taskId));

    return Scaffold(
      appBar: marinaAppBar(/*actions: [Icon(Icons.menu_rounded)]*/),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 36),
        child: Column(
          children: [
            Expanded(
              child: taskAsync.when(
                data: (task) {
                  return PageView(
                    onPageChanged: (value) {
                      ref.read(indexDotProvider.notifier).changeIndex(value);
                    },
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      taskPage1(ref, pageController, task),
                      taskPage2(ref, pageController, task),
                      taskPage3(ref, pageController, task),
                    ],
                  );
                },
                error: (e, st) => Text('Error loading task: $e'),
                loading: () => Center(child: marinaCircularProgressIndicator()),
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
