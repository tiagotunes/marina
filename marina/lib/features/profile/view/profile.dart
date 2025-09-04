import 'package:flutter/material.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/features/profile/view/widgets/profile_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: marinaAppBar(title: const Text("PERFIL")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
        child: Column(children: [Expanded(child: profilePage())]),
      ),
    );
  }
}
