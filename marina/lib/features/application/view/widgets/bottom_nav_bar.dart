import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/features/application/provider/bottom_nav_bar_notifier.dart';
import 'package:marina/features/application/view/widgets/bottom_nav_bar_items.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Widget bottomNavBar(WidgetRef ref) {
  int index = ref.watch(bottomNavBarNotifierProvider);

  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the container
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(color: Colours.lightThemePrimaryColour),
          child: SalomonBottomBar(
            currentIndex: index,
            onTap: (value) {
              ref
                  .read(bottomNavBarNotifierProvider.notifier)
                  .changeIndex(value);
            },
            backgroundColor: Colours.lightThemePrimaryColour,
            selectedItemColor: Colors.white,
            selectedColorOpacity: 0.25,
            unselectedItemColor: Colors.white,
            margin: const EdgeInsets.all(10),
            itemShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            items: bottomNavBarItems,
          ),
        ),
      ),
    ],
  );
}
