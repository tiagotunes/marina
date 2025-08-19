import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/sign_up/controller/sign_up_controller.dart';
import 'package:marina/features/sign_up/provider/sign_up_notifier.dart';

Widget signUpFields(SignUpController controller, WidgetRef ref) {
  return Column(
    children: [
      textField(
        controller: controller.emailController,
        func: (value) =>
            ref.read(signUpNotifierProvider.notifier).onEmailChange(value),
        prefix: Icon(Icons.email_rounded),
        label: "E-mail",
      ),
      SizedBox(height: 24),
      textField(
        controller: controller.passwordController,
        func: (value) =>
            ref.read(signUpNotifierProvider.notifier).onPasswordChange(value),
        prefix: Icon(Icons.password_rounded),
        label: "Palavra-passe",
        obscureText: true,
      ),
      SizedBox(height: 24),
      textField(
        controller: controller.rePasswordController,
        func: (value) =>
            ref.read(signUpNotifierProvider.notifier).onRePasswordChange(value),
        prefix: Icon(Icons.password_rounded),
        label: "Confirmar palavra-passe",
        obscureText: true,
      ),
      SizedBox(height: 24),
      textField(
        controller: controller.nameController,
        func: (value) =>
            ref.read(signUpNotifierProvider.notifier).onNameChange(value),
        prefix: Icon(Icons.person_rounded),
        label: "Nome",
      ),
      // SizedBox(height: 24),
      // textField(
      //   controller: controller.genderController,
      //   func: (value) =>
      //       ref.read(signUpNotifierProvider.notifier).onGenderChange(value),
      //   label: "Género",
      //   prefix: Icon(Icons.male_rounded),
      // ),
      // SizedBox(height: 24),
      // textField(
      //   controller: controller.roleController,
      //   func: (value) =>
      //       ref.read(signUpNotifierProvider.notifier).onRoleChange(value),
      //   label: "Função",
      //   prefix: Icon(Icons.functions_rounded),
      // ),
    ],
  );
}
