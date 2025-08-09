import 'package:marina/common/models/task.dart';
import 'package:marina/common/utils/typedefs.dart';
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

  void fetchTasks() async {
    try {
      final user = Global.storageService.getUserProfile();
      if (user.id != null && user.id!.isNotEmpty) {
        final response = await HomeRepo.getUserTasks(user.id!);

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
  }
}
