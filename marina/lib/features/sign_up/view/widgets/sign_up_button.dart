import 'package:flutter/material.dart';
import 'package:marina/features/sign_up/controller/sign_up_controller.dart';

Widget signUpButton(SignUpController controller) {
  return ElevatedButton(
    onPressed: () => controller.handleSignUp(),
    child: Text('Registar'),
  );
}
