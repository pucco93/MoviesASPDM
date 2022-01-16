import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';

import 'package:movies/SideDrawer/SideDrawer.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/HomeSection/HomePageBody/HomePageBody.dart';
import 'package:movies/SearchSection/SearchPage.dart';
import 'package:movies/ProfileSection/ProfilePage.dart';
import 'package:movies/FavouritesSection/FavouritesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      primary: Colors.redAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ));

  _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  _openProfile() {}

  _closeDrawer() {
    Navigator.pop(context);
  }

  _changeCurrentPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      const HomePageBody(),
      SearchPage(),
      const ProfilePage(),
      const FavouritesPage(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: ColorSelect.customBlue,
        leading: IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            onPressed: _openProfile),
        title: Center(
            child: RichText(
                text: const TextSpan(children: [
          TextSpan(
              text: "Hi",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          TextSpan(text: ", Ale", style: TextStyle(fontSize: 22))
        ]))),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu_rounded, size: 30),
              onPressed: _openDrawer),
          const Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      drawer: NavDrawer(
        closeDrawer: _closeDrawer,
      ),
      body: _pageOptions[currentPageIndex],
      bottomNavigationBar: BottomNav(
          changeCurrentPageIndex: _changeCurrentPageIndex,
          currentPageIndex: currentPageIndex),
    );
  }
}