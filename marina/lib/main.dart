import 'package:flutter/material.dart';
import 'package:marina/core/res/styles/colours.dart';
import 'package:marina/core/res/styles/text.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colours.lightThemePrimaryColour,
      ),
      fontFamily: 'Jura',
      scaffoldBackgroundColor: Colours.lightThemeBackgroundColour,
      appBarTheme: AppBarTheme(
        backgroundColor: Colours.lightThemeBackgroundColour,
        foregroundColor: Colours.lightThemePrimaryTextColour,
      ),
      useMaterial3: true,
    );
    return MaterialApp(
      title: 'Marina',
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: theme.copyWith(
        scaffoldBackgroundColor: Colours.darkThemeBackgroundColour,
        appBarTheme: AppBarTheme(
          backgroundColor: Colours.darkThemeBackgroundColour,
          foregroundColor: Colours.lightThemeWhiteColour,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyles.headingBold.copyWith(
              color: Colours.classicAdaptiveTextColour(context),
            ),
          ),
        ),
      ),
    );
  }
}
