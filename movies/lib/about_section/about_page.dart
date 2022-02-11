import 'package:flutter/material.dart';
import 'package:movies/colors/colors_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _backToPreviousPage() {
      Navigator.pop(context);
    }

    void _openLink() async {
      if (!await launch("https://github.com/pucco93/moviesASPDM/")) {
        throw 'Could not launch https://github.com/pucco93/moviesASPDM/';
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorSelect.customMagenta,
                  child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)),
            onPressed: _backToPreviousPage),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(children: [
              // Container(
              //     alignment: Alignment.topLeft,
              //     padding: const EdgeInsets.only(top: 20, left: 15),
              //     child: IconButton(
              //         icon: const Icon(Icons.arrow_back_ios,
              //              size: 30),
              //         onPressed: _backToPreviousPage)),
              const Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                          "This app is made with APIs coming from TMDb.com.",
                          style: TextStyle(fontSize: 20)))),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      height: 150,
                      width: 150,
                      child: const FittedBox(
                        child:
                            Image(image: AssetImage("assets/images/tmdb.png")),
                        fit: BoxFit.cover,
                      ))),
              const Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                          "The icon below is a link to the source code in GitHub.",
                          style: TextStyle(fontSize: 20)))),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                          child: const Image(
                              image:
                                  AssetImage("assets/images/github_logo.png")),
                          onTap: _openLink))),
              const Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("App version: 1.0.0",
                          style: TextStyle(fontSize: 20)))),
            ])));
  }
}
