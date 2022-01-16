import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'WelcomeSection/WelcomePage.dart';
import 'package:movies/models/providers/ProviderFavs.dart';
import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/models/providers/ProviderSearch.dart';
import 'package:movies/models/providers/ProviderAccount.dart';

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
    return MultiProvider(providers: [
        ChangeNotifierProvider<ProviderSearch>(create: (context) => ProviderSearch()),
        ChangeNotifierProvider<ProviderHome>(create: (context) => ProviderHome()),
        // ChangeNotifierProvider<ProviderAccount>(create: (context) => ProviderAccount()),
        // ChangeNotifierProvider<ProviderFavs>(create: (context) => ProviderFavs())
      ], child: MaterialApp(
      title: 'Movies',
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Montserrat'),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      home: const WelcomePage(),
    ));
  }
}
