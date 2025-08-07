import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/sign_up/provider/sign_up_notifier.dart';
import 'package:marina/features/sign_up/repo/sign_up_repo.dart';

class SignUpController {
  SignUpController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  void handleSignUp(WidgetRef ref) async {
    var state = ref.read(signUpNotifierProvider);

    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;
    String name = state.name;
    // String gender = state.gender;
    // String role = state.role;

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("Email is empty");
      return;
    }

    if (state.password.isEmpty ||
        password.isEmpty ||
        state.rePassword.isEmpty ||
        rePassword.isEmpty) {
      toastInfo("Password is empty");
      return;
    }
    if (state.password != state.rePassword) {
      toastInfo("Your password does not match");
      return;
    }

    if (state.name.isEmpty || name.isEmpty) {
      toastInfo("Name is empty");
      return;
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);
    var context = Navigator.of(ref.context);

    try {
      final response = await SignUpRepo.signIn(email, password, name);
      if (kDebugMode) {
        print("${response.statusCode} - ${response.body}");
      }

      context.pop();
      toastInfo("Successful register");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
      }
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
  }
}
