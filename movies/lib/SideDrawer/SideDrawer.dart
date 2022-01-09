import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/HomeSection/HomePage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.closeDrawer}) : super(key: key);
  final closeDrawer;

  @override
  Widget build(BuildContext context) {
    _goHome() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    _closeDrawer() {
      closeDrawer();
    }

    _openProfile() {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }

    _openFavourites() {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }

    _openPrivacyPolicy() {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }

    _openAbout() {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Align(child:Icon(Icons.arrow_back_outlined, size: 30), alignment: Alignment.center),
        backgroundColor: ColorSelect.customSalmon,
        onPressed: _closeDrawer,),
        body: Container(
            color: ColorSelect.customBlue,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: const Text("Home", style: TextStyle(fontSize: 22)),
                  leading: const Icon(Icons.home_outlined, size: 30),
                  onTap: _goHome,
                ),
                ListTile(
                  title:
                      const Text("Favourites", style: TextStyle(fontSize: 22)),
                  leading: const Icon(Icons.favorite_outline, size: 30),
                  onTap: _openFavourites,
                ),
                ListTile(
                  title: const Text("Profile", style: TextStyle(fontSize: 22)),
                  leading: const Icon(Icons.account_circle_outlined, size: 30),
                  onTap: _openProfile,
                ),
                ListTile(
                  title: const Text("About", style: TextStyle(fontSize: 22)),
                  leading: const Icon(Icons.info_outline, size: 30),
                  onTap: _openAbout,
                ),
                ListTile(
                  title: const Text("Privacy policy",
                      style: TextStyle(fontSize: 22)),
                  leading: const Icon(Icons.privacy_tip_outlined, size: 30),
                  onTap: _openPrivacyPolicy,
                )
              ],
            )));
  }
}
