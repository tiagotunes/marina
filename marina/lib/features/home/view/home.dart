import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/app_bar.dart';
import 'package:marina/common/widgets/search_bar.dart';
import 'package:marina/features/home/view/widgets/home_menu_bar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: searchBar(),
              ),
              const HomeMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
