import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/dots_indicator.dart';
import 'package:marina/features/task/provider/task_page_notifier.dart';
import 'package:marina/features/task/view/widget/task_page.dart';

class Task extends ConsumerStatefulWidget {
  const Task({super.key});

  @override
  ConsumerState<Task> createState() => _TaskState();
}

class _TaskState extends ConsumerState<Task> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexDotProvider);
    return Scaffold(
      appBar: marinaAppBar(actions: [Icon(Icons.menu_rounded)]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 36),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  ref.read(indexDotProvider.notifier).changeIndex(value);
                },
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [TaskPage1(), TaskPage1(), TaskPage1()],
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
