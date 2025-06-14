import 'package:flutter/material.dart';
import 'package:marina/core/common/widgets/app_bar_bottom.dart';
import 'package:marina/core/res/styles/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sessão', style: TextStyles.body1),
        bottom: const AppBarBottom(),
      ),
      body: Container(),
    );
  }
}
