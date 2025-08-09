import 'dart:async';

import 'package:marina/common/models/task.dart';
import 'package:marina/features/home/repo/home_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_task_notifier.g.dart';

@riverpod
class UserTasksNotifier extends _$UserTasksNotifier {
  @override
  FutureOr<List<UserTask>> build(String userId) async {
    final response = await HomeRepo.fetchUserTasks(userId);
    final List data = response.data;
    return data.map((json) => UserTask.fromJson(json)).toList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final response = await HomeRepo.fetchUserTasks(userId);
    final List data = response.data;
    state = AsyncValue.data(
      data.map((json) => UserTask.fromJson(json)).toList(),
    );
  }

  Future<void> addTask(Map<String, dynamic> taskData) async {
    await HomeRepo.createUserTasks(userId);
    await refresh();
  }
}
