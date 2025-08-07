import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/global_loader/global_loader.dart';
import 'package:marina/common/widgets/loader.dart';
import 'package:marina/common/widgets/primary_button.dart';
import 'package:marina/features/sign_up/controller/sign_up_controller.dart';

Widget signUpButton(SignUpController controller, WidgetRef ref) {
  final loader = ref.watch(globalLoaderProvider);

  return Center(
    child: primaryElevatedButton(
      func: () => controller.handleSignUp(ref),
      context: ref.context,
      center: loader ? marinaLoader() : Text('Registar'),
    ),
  );
}
