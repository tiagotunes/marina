import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/utils/constants.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/global.dart';
import 'package:marina/pages/sign_in/notifier/sign_in_notifier.dart';
import 'package:marina/common/entities/user.dart';

class SignInController {
  WidgetRef ref;

  SignInController(this.ref);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleSignIn() async {
    var state = ref.read(signInNotifierProvider);

    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("Email is empty");
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      toastInfo("Password is empty");
      return;
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(true);
    // var context = Navigator.of(ref.context);

    try {
      LoginRequestEntity loginRequestEntity = LoginRequestEntity();

      // asyncPostAllData(loginRequestEntity);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/v1/login'),
        headers: {
          'Content-Type':
              'application/json', // 'application/x-www-form-urlencoded' or whatever you need
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      toastInfo("Successful sign in ");
      print("${response.statusCode} - ${response.body}");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
  }
}

void asyncPostAllData(LoginRequestEntity loginRequestEntity) {
  // Talk to server

  // Have local storage
  try {
    Global.storageService.setString(Constants.STORAGE_USER_PROFILE_KEY, "123");
    Global.storageService.setString(Constants.STORAGE_USER_TOKEN_KEY, "123456");
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }

  // Redirect to new page
}
