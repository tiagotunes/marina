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
      scaffoldBackgroundColor: Colours.lightThemeTintStockColour,
      appBarTheme: AppBarTheme(
        backgroundColor: Colours.lightThemeTintStockColour,
        foregroundColor: Colours.lightThemePrimaryTextColour,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'MARINA',
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: theme.copyWith(
        scaffoldBackgroundColor: Colours.darkThemeBgdDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colours.darkThemeBgdDark,
          foregroundColor: Colours.lightThemeWhiteColour,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyles.heading0.copyWith(
              color: Colours.classicAdaptiveTextColour(context),
            ),
          ),
        ),
      ),
    );
  }
}
