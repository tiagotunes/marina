import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/home/repo/home_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_task_notifier.g.dart';

@riverpod
class UserTasksNotifier extends _$UserTasksNotifier {
  @override
  FutureOr<List<UserTask>> build(String userId) async {
    try {
      final response = await HomeRepo.fetchUserTasks(userId);
      final List data = response.data;
      return data.map((json) => UserTask.fromJson(json)).toList();
    } on DioException catch (e) {
      // Display the message set in the interceptor
      toastInfo(e.error.toString());
      if (kDebugMode) {
        print("Sign in failed: ${e.error}");
      }
      return [];
    } catch (e) {
      toastInfo("Unexpected error");
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    } finally {
      ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final response = await HomeRepo.fetchUserTasks(userId);
    final List data = response.data;
    state = AsyncValue.data(
      data.map((json) => UserTask.fromJson(json)).toList(),
    );
  }

  Future<void> addTask() async {
    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);
    try {
      await HomeRepo.createUserTasks(userId);
      await refresh();
    } on DioException catch (e) {
      // Display the message set in the interceptor
      toastInfo(e.error.toString());
      if (kDebugMode) {
        print("Sign in failed: ${e.error}");
      }
    } catch (e) {
      toastInfo("Unexpected error");
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}
