import 'package:flutter/material.dart';
import 'package:movies/AboutSection/AboutPage.dart';

import 'package:movies/SideDrawer/SideDrawer.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/HomeSection/HomePageBody/HomePageBody.dart';
import 'package:movies/SearchSection/SearchPage.dart';
import 'package:movies/ProfileSection/ProfilePage.dart';
import 'package:movies/FavouritesSection/FavouritesPage.dart';
import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/AppBar/AppBar.dart';
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
    homeProvider.updateScaffoldKey(_scaffoldKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      const HomePageBody(),
      SearchPage(),
      ProfilePage(),
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
