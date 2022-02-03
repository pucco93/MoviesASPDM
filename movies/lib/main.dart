import 'dart:io';
import 'package:movies/HomeSection/HomePage.dart';
import 'package:movies/models/providers/ProviderSignIn.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'WelcomeSection/WelcomePage.dart';
import 'models/providers/ProviderFavs.dart';
import 'models/providers/ProviderHome.dart';
import 'models/providers/ProviderSearch.dart';
import 'models/providers/ProviderAccount.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/typeAdapters/Movie.dart';
import 'models/typeAdapters/Person.dart';
import 'models/typeAdapters/TVSerie.dart';
import 'models/typeAdapters/LoggedUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(MovieHiveAdapter());
  Hive.registerAdapter(TVSerieHiveAdapter());
  Hive.registerAdapter(PersonHiveAdapter());
  Hive.registerAdapter(LoggedUserAdapter());
  await Hive.openBox<dynamic>('dataBox');
  await Hive.openBox<dynamic>('userBox');
  await Hive.openBox('favBox');

  runApp(const MyApp());
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderSearch>(
              create: (context) => ProviderSearch()),
          ChangeNotifierProvider<ProviderHome>(
              create: (context) => ProviderHome()),
          ChangeNotifierProvider<ProviderAccount>(
              create: (context) => ProviderAccount()),
          ChangeNotifierProvider<ProviderFavs>(
              create: (context) => ProviderFavs()),
          ChangeNotifierProvider<ProviderSignIn>(
              create: (context) => ProviderSignIn())
        ],
        child: MaterialApp(
          title: 'Movies',
          theme:
              ThemeData(brightness: Brightness.light, fontFamily: 'Montserrat'),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: themeMode,
          home: Consumer<ProviderAccount>(
              builder: (context, accountProvider, child) {
            return accountProvider.isLogged
                ? const HomePage()
                : const WelcomePage();
          }),
        ));
  }
}
