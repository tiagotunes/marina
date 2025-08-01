import 'package:flutter/material.dart';
import 'package:marina/pages/sign_in/sign_in_controller.dart';

Widget signInButton(SignInController controller) {
  return Center(
    child: ElevatedButton(
      onPressed: () => controller.handleSignIn(),
      child: SizedBox(height: 50, child: Center(child: Text('Iniciar Sessão'))),
    ),
  );
}
