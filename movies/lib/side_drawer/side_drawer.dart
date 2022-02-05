import 'package:flutter/material.dart';
import 'package:movies/about_section/about_page.dart';
import 'package:movies/colors/colors_theme.dart';
import 'package:movies/easter_eggs/terms_policy.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key, required this.closeDrawer}) : super(key: key);
  final closeDrawer;

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      primary: ColorSelect.customMagenta,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final ButtonStyle _textButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    void _goHome(ProviderHome homeProvider) {
      homeProvider.updateCurrentPageIndex(0);
      closeDrawer();
    }

    void _closeDrawer() {
      closeDrawer();
    }

    void _openSearch(ProviderHome homeProvider) {
      homeProvider.updateCurrentPageIndex(1);
      closeDrawer();
    }

    void _openProfile(ProviderHome homeProvider) {
      homeProvider.updateCurrentPageIndex(2);
      closeDrawer();
    }

    void _openFavourites(ProviderHome homeProvider) {
      homeProvider.updateCurrentPageIndex(3);
      closeDrawer();
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorSelect.customBlue,
            titleTextStyle: const TextStyle(color: Colors.white),
            contentTextStyle: const TextStyle(color: Colors.white),
            title: const Text('Privacy Policy'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to read privacy policy?'),
                  Text(
                      "C'mon you don't wanna read privacy policy, no one really needs it."),
                  Text("...please..."),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Read'),
                style: _buttonStyle,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsPolicy()));
                },
              ),
              TextButton(
                child: const Text('Close'),
                style: _textButton,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _openFakePolicy() {
      _showMyDialog();
    }

    _openAbout() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AboutPage()));
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Align(
              child: Icon(Icons.arrow_back_outlined, size: 30),
              alignment: Alignment.center),
          backgroundColor: ColorSelect.customSalmon,
          onPressed: _closeDrawer,
        ),
        body: Container(
            color: ColorSelect.customBlue,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child:
                Consumer<ProviderHome>(builder: (context, homeProvider, child) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text("Home", style: TextStyle(fontSize: 22)),
                    leading: const Icon(Icons.home_outlined, size: 30),
                    onTap: () => _goHome(homeProvider),
                  ),
                  ListTile(
                    title: const Text("Search", style: TextStyle(fontSize: 22)),
                    leading: const Icon(Icons.search_outlined, size: 30),
                    onTap: () => _openSearch(homeProvider),
                  ),
                  ListTile(
                    title:
                        const Text("Profile", style: TextStyle(fontSize: 22)),
                    leading:
                        const Icon(Icons.account_circle_outlined, size: 30),
                    onTap: () => _openProfile(homeProvider),
                  ),
                  ListTile(
                    title: const Text("Favourites",
                        style: TextStyle(fontSize: 22)),
                    leading: const Icon(Icons.favorite_outline, size: 30),
                    onTap: () => _openFavourites(homeProvider),
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
                    onTap: _openFakePolicy,
                  )
                ],
              );
            })));
  }
}
