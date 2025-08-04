import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/application/view/widgets/bottom_nav_bar.dart';
import 'package:marina/features/application/view/widgets/application_screens.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: applcationScreens(ref),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: bottomNavBar(ref),
      ),
    );
  }
}
