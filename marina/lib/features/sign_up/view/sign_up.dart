import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/utils/image_res.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/features/sign_up/provider/sign_up_notifier.dart';
import 'package:marina/features/sign_up/controller/sign_up_controller.dart';
import 'package:marina/features/sign_up/view/widgets/sign_up_button.dart';
import 'package:marina/features/sign_up/view/widgets/sign_up_fields.dart';

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
              signUpFields(_controller, ref),
              SizedBox(height: 64),
              signUpButton(_controller, ref),
            ],
          ),
        ),
      ),
    );
  }
}
