import 'package:flutter/material.dart';
import 'package:marina/pages/sign_up/sign_up_controller.dart';

Widget registerButton(SignUpController controller) {
  return ElevatedButton(
    onPressed: () => controller.handleSignUp(),
    child: Text('Registar'),
  );
}
