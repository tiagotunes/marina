import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/utils/typedefs.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/home/repo/home_repo.dart';
import 'package:marina/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_task_notifier.g.dart';

@riverpod
class UserTaskNotifier extends _$UserTaskNotifier {
  @override
  List<UserTask> build() {
    return [];
  }

  void fetchUserTasks() async {
    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);

    try {
      final user = Global.storageService.getUserProfile();
      if (user.id != null && user.id!.isNotEmpty) {
        final response = await HomeRepo.fetchUserTasks(user.id!);

        if (response.statusCode == 200) {
          final List data = response.data;
          state = data.map((e) => UserTask.fromJson(DataMap.from(e))).toList();
        } else {
          state = [];
        }
      }
    } catch (e) {
      state = [];
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
  }

  void createUserTasks() async {
    try {
      final user = Global.storageService.getUserProfile();
      if (user.id != null && user.id!.isNotEmpty) {
        final response = await HomeRepo.createUserTasks(user.id!);
        if (response.statusCode == 204) {
          fetchUserTasks();
        } else {
          final msg = (response.data is Map && response.data['message'] != null)
              ? response.data['message']
              : 'Error creating user tasks';
          toastInfo(msg);
        }
      }
    } on DioException catch (e) {
      // Display the message set in the interceptor
      toastInfo(e.error.toString());
      if (kDebugMode) {
        print("Create User Task failed: ${e.error}");
      }
    } catch (e) {
      toastInfo("Unexpected error");
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
