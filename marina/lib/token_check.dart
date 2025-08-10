import 'package:flutter/material.dart';
import 'package:marina/common/services/http_util.dart';
import 'package:marina/features/application/view/application.dart';
import 'package:marina/features/sign_in/view/sign_in.dart';

class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});

  @override
  State<TokenCheck> createState() => _TokenCheckState();
}

class _TokenCheckState extends State<TokenCheck> {
  @override
  void initState() {
    super.initState();
    _verify();
  }

  Future<void> _verify() async {
    bool valid = await HttpUtil().isTokenValid();
    if (!mounted) return;

    if (valid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Application()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
