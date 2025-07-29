import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/pages/sign_up/notifier/register_notifier.dart';
import 'package:marina/pages/sign_up/sign_up_controller.dart';
import 'package:marina/pages/sign_up/widgets/register_button.dart';
import 'package:marina/pages/sign_up/widgets/sign_up_app_bar.dart';
import 'package:marina/pages/sign_up/widgets/sign_up_text_field.dart';

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
    // final registerProvider = ref.watch(registerNotifierProvider);
    return Scaffold(
      appBar: signUpAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onEmailChange(value),
                icon: Icons.email_rounded,
                label: "E-mail",
              ),
              SizedBox(height: 24),
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onPasswordChange(value),
                icon: Icons.password_rounded,
                label: "Palavra-passe",
                obscureText: true,
              ),
              SizedBox(height: 24),
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onRePasswordChange(value),
                icon: Icons.password_rounded,
                label: "Confirmar palavra-passe",
                obscureText: true,
              ),
              SizedBox(height: 24),
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onUsernameChange(value),
                icon: Icons.person_rounded,
                label: "Nome",
              ),
              SizedBox(height: 24),
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onGenderChange(value),
                label: "Género",
                icon: Icons.male_rounded,
              ),
              SizedBox(height: 24),
              signUpTextField(
                func: (value) => ref
                    .read(registerNotifierProvider.notifier)
                    .onRoleChange(value),
                label: "Função",
                icon: Icons.functions_rounded,
              ),
              SizedBox(height: 64),
              registerButton(_controller),
            ],
          ),
        ),
      ),
    );
  }
}
