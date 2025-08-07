import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// var bottomNavTabs = <BottomNavigationBarItem>[
//   bottomNavBarItem(icon: Icons.home_rounded, label: "Home"),
//   bottomNavBarItem(icon: Icons.person_rounded, label: "Profile"),
//   bottomNavBarItem(icon: Icons.info_rounded, label: "Settings"),
//   bottomNavBarItem(icon: Icons.home_rounded, label: "Info"),
// ];

// BottomNavigationBarItem bottomNavBarItem({
//   IconData icon = Icons.error_outline_sharp,
//   String label = "<label>",
// }) {
//   return BottomNavigationBarItem(
//     backgroundColor: Colors.transparent,
//     icon: Icon(icon),
//     label: label,
//   );
// }

var bottomNavBarItems = <SalomonBottomBarItem>[
  bottomNavBarItem(icon: Icons.home_rounded, title: "Início"),
  bottomNavBarItem(icon: Icons.person_rounded, title: "Perfil"),
  bottomNavBarItem(icon: Icons.settings, title: "Deinições"),
  bottomNavBarItem(icon: Icons.info_rounded, title: "Sobre"),
];

SalomonBottomBarItem bottomNavBarItem({
  IconData icon = Icons.error_outline_sharp,
  String title = "<title>",
}) {
  return SalomonBottomBarItem(
    icon: Icon(icon, size: 30),
    title: Text(
      title,
      style: TextStyles.button.copyWith(color: Colours.lightThemeWhiteColour),
    ),
  );
}
