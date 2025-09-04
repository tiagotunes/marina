import 'package:flutter/material.dart';
import 'package:marina/common/widgets/app_bar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: marinaAppBar(title: const Text("DEFINIÇÕES")));
  }
}
