import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/models/user_model.dart';
import 'package:marina/common/utils/constants.dart';
import 'package:marina/common/utils/typedefs.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/features/sign_in/repo/sign_in_repo.dart';
import 'package:marina/global.dart';
import 'package:marina/features/sign_in/provider/sign_in_notifier.dart';
import 'package:marina/main.dart';

class SignInController {
  SignInController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleSignIn(WidgetRef ref) async {
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

    try {
      final response = await SignInRepo.signIn(email, password);
      if (kDebugMode) {
        print("${response.statusCode} - ${response.body}");
      }

      final payload = jsonDecode(response.body) as DataMap;

      if (response.statusCode != 200) {
        toastInfo("Error sign in");
      } else {
        toastInfo("Successful sign in");

        final user = UserModel.fromMap(payload);
        asyncPostAllData(user);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    ref.read(globalLoaderProvider.notifier).setLoaderValue(false);
  }

  void asyncPostAllData(UserModel user) {
    try {
      Global.storageService.setString(
        Constants.STORAGE_USER_SESSION_TOKEN,
        "123",
      );
      Global.storageService.setString(Constants.STORAGE_USER_ID, "123456");

      navKey.currentState?.pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
