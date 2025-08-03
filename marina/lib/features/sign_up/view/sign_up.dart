import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/sign_up/provider/sign_up_notifier.dart';
import 'package:marina/features/sign_up/controller/sign_up_controller.dart';
import 'package:marina/features/sign_up/view/widgets/sign_up_button.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = ref.watch(signUpNotifierProvider);
    final loader = ref.watch(globalLoaderProvider);

    return Scaffold(
      appBar: marinaAppBar(title: "Registar"),
      body: !loader
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    textField(
                      controller: _controller.emailController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onEmailChange(value),
                      icon: Icons.email_rounded,
                      label: "E-mail",
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.passwordController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onPasswordChange(value),
                      icon: Icons.password_rounded,
                      label: "Palavra-passe",
                      obscureText: true,
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.rePasswordController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onRePasswordChange(value),
                      icon: Icons.password_rounded,
                      label: "Confirmar palavra-passe",
                      obscureText: true,
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.nameController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onNameChange(value),
                      icon: Icons.person_rounded,
                      label: "Nome",
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.genderController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onGenderChange(value),
                      label: "Género",
                      icon: Icons.male_rounded,
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.roleController,
                      func: (value) => ref
                          .read(signUpNotifierProvider.notifier)
                          .onRoleChange(value),
                      label: "Função",
                      icon: Icons.functions_rounded,
                    ),
                    SizedBox(height: 64),
                    signUpButton(_controller),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
