import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/utils/image_res.dart';
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
  void didChangeDependencies() {
    _controller = SignUpController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(signUpNotifierProvider);

    return Scaffold(
      appBar: marinaAppBar(
        autoImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              ImageRes.logo,
              fit: BoxFit.fitHeight,
              height: kToolbarHeight,
            ),
            SizedBox(width: 12.0),
            Text('Registar'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              textField(
                controller: _controller.emailController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onEmailChange(value),
                prefix: Icon(Icons.email_rounded),
                label: "E-mail",
              ),
              SizedBox(height: 24),
              textField(
                controller: _controller.passwordController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onPasswordChange(value),
                prefix: Icon(Icons.password_rounded),
                label: "Palavra-passe",
                obscureText: true,
              ),
              SizedBox(height: 24),
              textField(
                controller: _controller.rePasswordController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onRePasswordChange(value),
                prefix: Icon(Icons.password_rounded),
                label: "Confirmar palavra-passe",
                obscureText: true,
              ),
              SizedBox(height: 24),
              textField(
                controller: _controller.nameController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onNameChange(value),
                prefix: Icon(Icons.person_rounded),
                label: "Nome",
              ),
              SizedBox(height: 24),
              textField(
                controller: _controller.genderController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onGenderChange(value),
                label: "Género",
                prefix: Icon(Icons.male_rounded),
              ),
              SizedBox(height: 24),
              textField(
                controller: _controller.roleController,
                func: (value) => ref
                    .read(signUpNotifierProvider.notifier)
                    .onRoleChange(value),
                label: "Função",
                prefix: Icon(Icons.functions_rounded),
              ),
              SizedBox(height: 64),
              signUpButton(_controller, ref),
            ],
          ),
        ),
      ),
    );
  }
}
