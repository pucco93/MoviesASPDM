import 'dart:io';
import 'package:movies/Constants/constants.dart';
import 'package:movies/Utilities/utilities.dart';
import 'package:movies/home_section/homepage.dart';
import 'package:movies/models/interfaces/user.dart';
import 'package:movies/models/providers/provider_sign_in.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'welcome_section/welcome_page.dart';
import 'models/providers/provider_favs.dart';
import 'models/providers/provider_home.dart';
import 'models/providers/provider_search.dart';
import 'models/providers/provider_account.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/type_adapters/movie_hive.dart';
import 'models/type_adapters/person_hive.dart';
import 'models/type_adapters/tv_serie.dart';
import 'models/type_adapters/logged_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(MovieHiveAdapter());
  Hive.registerAdapter(TVSerieHiveAdapter());
  Hive.registerAdapter(PersonHiveAdapter());
  Hive.registerAdapter(LoggedUserAdapter());
  await Hive.openBox<dynamic>('dataBox');
  await Hive.openBox<LoggedUser>('userBox');
  await Hive.openBox('favBox');

  // Used to clear boxes in debug
  // final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
  // final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
  // final Box<dynamic> _favBox = Hive.box<dynamic>("favBox");
  // _userBox.deleteFromDisk();
  // _dataBox.deleteFromDisk();
  // _favBox.deleteFromDisk();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");

  @override
  Widget build(BuildContext context) {
    dynamic tempUser;
    if (_userBox.get("loggedUser") != null) {
      tempUser = Utilities.mapLoggedUser(_userBox.get("loggedUser"));
    } else {
      tempUser = initialLoggedUser;
    }

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
          debugShowCheckedModeBanner: false,
          title: 'Movies',
          theme:
              ThemeData(brightness: Brightness.light, fontFamily: 'Montserrat'),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: themeMode,
          home: Consumer<ProviderAccount>(
              builder: (context, accountProvider, child) {
            return accountProvider.isLogged || tempUser.isLogged
                ? const HomePage()
                : const WelcomePage();
          }),
        ));
  }
}
