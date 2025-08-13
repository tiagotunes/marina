import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/utils/typedefs.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/features/task/provider/measure_notifier.dart';
import 'package:marina/features/task/repo/task_repo.dart';
import 'package:marina/global.dart';
import 'package:marina/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_notifier.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  FutureOr<TaskModel> build(String taskId) async {
    try {
      final response = await TaskRepo.getTaskDetails(taskId);
      final task = TaskModel.fromJson(response.data);

      // Seed measure state with DB values
      if (task.measures != null) {
        final initialValues = {
          for (final m in task.measures!)
            if (m.id != null) m.id!: m.value ?? 0,
        };
        ref.read(measureNotifierProvider.notifier).setAll(initialValues);
      }

      return task;
    } on DioException catch (e) {
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

  Future<void> submitTask({
    required String taskId,
    required DataMap measures,
  }) async {
    final hasInvalid = measures.values.any((v) => v <= 0);
    if (hasInvalid) {
      toastInfo("Por favor, atribui um valor a todas as medidas.");
      return;
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);
    try {
      for (final measure in measures.entries) {
        if (measure.value != 0) {
          await TaskRepo.updateTaskDetails(taskId, measure.key, measure.value);
        }
      }
      await ref
          .read(
            userTasksNotifierProvider(
              Global.storageService.getUserProfile().id!,
            ).notifier,
          )
          .refresh();
      navKey.currentState?.pushNamedAndRemoveUntil(
        '/application',
        (route) => false,
      );

      toastInfo("Task submitted successfully!");
    } catch (e) {
      toastInfo("Failed to submit task");
      if (kDebugMode) {
        print("Submit error: $e");
      }
    } finally {
      ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}
