import 'package:flutter/material.dart';
import 'package:marina/common/widgets/app_bar.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: marinaAppBar(title: const Text("SOBRE")));
  }
}
