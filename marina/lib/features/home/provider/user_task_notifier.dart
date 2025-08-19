import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/home/repo/home_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_task_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserTasksNotifier extends _$UserTasksNotifier {
  @override
  FutureOr<List<UserTask>> build(String userId) async {
    return _fetchTasks();
  }

  Future<List<UserTask>> _fetchTasks() async {
    try {
      final response = await HomeRepo.fetchUserTasks(userId);
      final List data = response.data;
      return data.map((json) => UserTask.fromJson(json)).toList();
    } on DioException catch (e) {
      toastInfo(e.error.toString());
      debugPrint("User Task failed: ${e.error}");
      rethrow;
    } catch (e) {
      toastInfo("Unexpected error");
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _fetchTasks());
  }

  Future<void> addTask() async {
    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);
    try {
      await HomeRepo.createUserTasks(userId);
      await refresh(); // no Future.delayed
    } on DioException catch (e) {
      toastInfo(e.error.toString());
      debugPrint("User Task failed: ${e.error}");
    } catch (e) {
      toastInfo("Unexpected error");
      debugPrint(e.toString());
    } finally {
      ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}
