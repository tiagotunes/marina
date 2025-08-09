import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/search_bar.dart';
import 'package:marina/features/home/controller/user_task_controller.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final UserTasksController _controller = UserTasksController();

  @override
  void initState() {
    Future.microtask(() => _controller.loadTasks(ref));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              tasks.isEmpty
                  ? const Text("No tasks assigned")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return ListTile(
                          title: Text(task.docTitle ?? ""),
                          subtitle: Text(
                            "Deadline: ${task.dtDeadline?.toLocal().toString().substring(0, 16)}",
                          ),
                          trailing: Icon(
                            task.read == true
                                ? Icons.check_circle
                                : Icons.pending,
                            color: task.read == true
                                ? Colors.green
                                : Colors.orange,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
