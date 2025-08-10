import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/task/repo/task_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_notifier.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  FutureOr<TaskModel> build(String taskId) async {
    try {
      final response = await TaskRepo.getTaskDetails(taskId);
      return TaskModel.fromJson(response.data);
    } on DioException catch (e) {
      // Display the message set in the interceptor
      toastInfo(e.error.toString());
      if (kDebugMode) {
        print("Task failed: ${e.error}");
      }
      return TaskModel();
    } catch (e) {
      toastInfo("Unexpected error");
      if (kDebugMode) {
        print(e.toString());
      }
      return TaskModel();
    } finally {
      ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}
