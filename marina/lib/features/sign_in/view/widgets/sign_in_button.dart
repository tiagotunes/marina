import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/features/sign_in/controller/sign_in_controller.dart';

Widget signInButton(SignInController controller, WidgetRef ref) {
  return Center(
    child: ElevatedButton(
      onPressed: () => controller.handleSignIn(ref),
      child: SizedBox(height: 50, child: Center(child: Text('Iniciar Sessão'))),
    ),
  );
}
