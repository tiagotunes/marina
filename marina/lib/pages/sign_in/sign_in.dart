import 'package:flutter/material.dart';
import 'package:marina/pages/sign_in/widgets/sign_in_app_bar.dart';
import 'package:marina/pages/sign_in/widgets/sign_in_button.dart';
import 'package:marina/pages/sign_in/widgets/sign_in_text_fields.dart';
import 'package:marina/pages/sign_in/widgets/sign_up_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signInAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              signInTextFields(),
              SizedBox(height: 8),
              Text("Esqueceu a palavra-passe?"),
              SizedBox(height: 64),
              signInButton(),
              SizedBox(height: 24),
              signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
