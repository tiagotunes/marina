import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/sign_in/controller/sign_in_controller.dart';
import 'package:marina/features/sign_in/provider/sign_in_notifier.dart';

Widget signInFields(SignInController controller, WidgetRef ref) {
  final loader = ref.watch(globalLoaderProvider);
  return Column(
    children: [
      textField(
        enabled: !loader,
        controller: controller.emailController,
        label: 'Email',
        prefix: Icon(Icons.email),
        func: (value) =>
            ref.read(signInNotifierProvider.notifier).onEmailChange(value),
      ),
      SizedBox(height: 24),
      textField(
        enabled: !loader,
        controller: controller.passwordController,
        label: 'Palavra-passe',
        prefix: Icon(Icons.password),
        func: (value) =>
            ref.read(signInNotifierProvider.notifier).onPasswordChange(value),
        obscureText: true,
      ),
    ],
  );
}
