import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/sign_in/provider/sign_in_notifier.dart';
import 'package:marina/features/sign_in/controller/sign_in_controller.dart';
import 'package:marina/features/sign_in/view/widgets/sign_in_button.dart';
import 'package:marina/features/sign_in/view/widgets/sign_up_button.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;

  @override
  void didChangeDependencies() {
    _controller = SignInController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(signInNotifierProvider);
    final loader = ref.watch(globalLoaderProvider);

    return Scaffold(
      appBar: marinaAppBar(title: 'Iniciar Sessão'),
      body: !loader
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    textField(
                      controller: _controller.emailController,
                      label: 'Email',
                      icon: Icons.email,
                      func: (value) => ref
                          .read(signInNotifierProvider.notifier)
                          .onEmailChange(value),
                    ),
                    SizedBox(height: 24),
                    textField(
                      controller: _controller.passwordController,
                      label: 'Palavra-passe',
                      icon: Icons.password,
                      func: (value) => ref
                          .read(signInNotifierProvider.notifier)
                          .onPasswordChange(value),
                      obscureText: true,
                    ),
                    SizedBox(height: 8),
                    Text("Esqueceu a palavra-passe?"),
                    SizedBox(height: 64),
                    signInButton(_controller, ref),
                    SizedBox(height: 24),
                    signUpButton(context),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
