import 'package:flutter/material.dart';
import 'package:marina/common/widgets/app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: marinaAppBar(title: const Text("PERFIL")));
  }
}
