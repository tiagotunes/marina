import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/progress_indicator.dart';
import 'package:marina/common/widgets/refresh_indicator.dart';
import 'package:marina/common/widgets/search_bar.dart';
import 'package:marina/features/home/provider/user_task_notifier.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar.dart';
import 'package:marina/features/home/provider/home_controller.dart';
import 'package:marina/features/home/view/widgets/home_task_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(homeUserProfileProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(homeUserProfileProvider);

    return userProfileAsync.when(
      data: (userProfile) {
        final tasksAsync = ref.watch(
          userTasksNotifierProvider(userProfile.id!),
        );

        return Scaffold(
          appBar: marinaAppBar(title: const Text("MARINA")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                searchBar(),
                const SizedBox(height: 24),
                homeMenuBar(context, ref),
                const SizedBox(height: 24),
                tasksAsync.when(
                  data: (tasks) {
                    if (tasks.isEmpty) return const Text("Sem tarefas");
                    return Expanded(
                      child: marinaResfreshIndicator(
                        () => ref
                            .read(
                              userTasksNotifierProvider(
                                userProfile.id!,
                              ).notifier,
                            )
                            .refresh(),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return homeTaskCard(ref, userProfile.id!, task);
                          },
                        ),
                      ),
                    );
                  },
                  loading: () => Expanded(
                    child: Center(child: marinaCircularProgressIndicator()),
                  ),
                  error: (e, _) =>
                      Expanded(child: Text('Error loading tasks: $e')),
                ),
              ],
            ),
          ),
        );
      },
      loading: () =>
          Scaffold(body: Center(child: marinaCircularProgressIndicator())),
      error: (e, st) =>
          Scaffold(body: Center(child: Text('Error loading user profile: $e'))),
    );
  }
}
