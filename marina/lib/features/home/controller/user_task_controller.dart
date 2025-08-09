import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';

class UserTasksController {
  UserTasksController();

  Future<void> loadTasks(WidgetRef ref) async {
    ref.read(userTaskNotifierProvider.notifier).fetchTasks();
  }
}
