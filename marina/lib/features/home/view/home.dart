import 'package:flutter/material.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/search_bar.dart';
import 'package:marina/global.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: marinaAppBar(title: Text("MARINA")),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello,", style: TextStyle(fontSize: 18)),
              Text(
                Global.storageService.getUserProfile().name!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: searchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
