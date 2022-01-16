import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'WelcomeSection/WelcomePage.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/data_manager/DataManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode;
    switch (WidgetsBinding.instance?.window.platformBrightness.name) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
        break;
    }
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Montserrat'),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      home: const WelcomePage(),
    );
  }
}
