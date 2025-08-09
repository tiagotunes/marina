import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/loader.dart';
import 'package:marina/common/widgets/search_bar.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar.dart';
import 'package:marina/features/home/view/widgets/home_task_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    Future.microtask(
      () => ref.read(userTaskNotifierProvider.notifier).fetchUserTasks(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(globalLoaderProvider);
    final tasks = ref.watch(userTaskNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: marinaAppBar(title: Text("MARINA")),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: searchBar(),
              ),
              const HomeMenuBar(),
              const SizedBox(height: 24),
              loader
                  ? Center(child: marinaLoader())
                  : tasks.isEmpty
                  ? Center(child: const Text("No tasks assigned"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return homeTaskCard(task);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
