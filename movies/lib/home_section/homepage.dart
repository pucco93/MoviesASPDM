import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:movies/about_section/about_page.dart';
import 'package:movies/models/interfaces/user.dart';
import 'package:movies/models/providers/provider_account.dart';
import 'package:movies/models/type_adapters/logged_user.dart';

import 'package:movies/side_drawer/side_drawer.dart';
import 'package:movies/bottom_nav/bottom_nav.dart';
import 'package:movies/home_section/home_page_body/homepage_body.dart';
import 'package:movies/search_section/search_page.dart';
import 'package:movies/profile_section/profile_page.dart';
import 'package:movies/favourites_section/favourites_page.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:movies/app_bar/app_bar.dart';
import 'package:movies/utilities/utilities.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      primary: Colors.redAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ));

  _closeDrawer() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    ProviderHome homeProvider =
        Provider.of<ProviderHome>(context, listen: false);
    ProviderAccount accountProvider =
        Provider.of<ProviderAccount>(context, listen: false);
    homeProvider.updateScaffoldKey(_scaffoldKey);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
      if (_userBox.get("loggedUser") != null) {
        dynamic tempUser = Utilities.mapLoggedUser(_userBox.get("loggedUser"));
        final User user =
            User(tempUser.name, tempUser.email, tempUser.password, "");
        if (tempUser.isLogged) {
          accountProvider.updateUser(user);
          accountProvider.updateLogStatus(true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      const HomePageBody(),
      const SearchPage(),
      const ProfilePage(),
      const FavouritesPage(),
      const AboutPage()
    ];

    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const CustomAppBar(),
        drawer: NavDrawer(
          closeDrawer: _closeDrawer,
        ),
        body: _pageOptions[homeProvider.currentPageIndex],
        bottomNavigationBar: const BottomNav(),
      );
    });
  }
}
