import 'package:flutter/material.dart';
import 'package:marina/core/res/styles/colours.dart';
import 'package:marina/core/services/injection_container.dart';
import 'package:marina/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
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

    return MaterialApp.router(
      title: 'MARINA',
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: theme.copyWith(
        scaffoldBackgroundColor: Colours.darkThemeBgdDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colours.darkThemeBgdDark,
          foregroundColor: Colours.lightThemeWhiteColour,
        ),
      ),
    );
  }
}
