import 'package:flutter/material.dart';
import 'package:marina/core/common/widgets/marina_logo.dart';
import 'package:marina/core/res/styles/colours.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemeTintStockColour,
      body: Center(child: MarinaLogo()),
    );
  }
}
