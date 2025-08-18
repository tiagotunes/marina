import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/progress_indicator.dart';
import 'package:marina/common/widgets/primary_button.dart';
import 'package:marina/features/sign_in/controller/sign_in_controller.dart';

Widget signInButton(SignInController controller, WidgetRef ref) {
  final loader = ref.watch(globalLoaderProvider);

  return Center(
    child: primaryElevatedButton(
      func: () => controller.handleSignIn(ref),
      context: ref.context,
      center: loader
          ? marinaCircularProgressIndicator()
          : Text("Iniciar Sessão"),
    ),
  );
}
