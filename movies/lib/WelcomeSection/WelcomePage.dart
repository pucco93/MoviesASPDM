import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/movies_main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double currentPageIndex = 0.0;
  final int _dotsCount = 4;

  void _incrementCounter() {
    if (currentPageIndex < 3) {
      setState(() {
        currentPageIndex++;
      });
    }
  }

  void _decrementCounter() {
    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
      });
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      primary: Colors.redAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ));

  String _isNext() {
    if (currentPageIndex == 3) {
      return "Start";
    } else {
      return "Next";
    }
  }

  void updateDirection(PageController pageController) {
    if (currentPageIndex > pageController.page!.round()) {
      _decrementCounter();
    } else {
      _incrementCounter();
    }
  }

  void changePage(PageController pageController) {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  final ButtonStyle skipStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      primary: Colors.grey[700],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ));

  @override
  Widget build(BuildContext context) {
    skipTutorial() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    final PageController _pageController = PageController(
      initialPage: 0,
    );
    return Scaffold(
        body: Column(children: [
      Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.only(top: 20, right: 20),
        child: ElevatedButton(
            style: skipStyle,
            onPressed: skipTutorial,
            child: const Text('Skip')),
      ),
      Expanded(
          child: PageView(
              controller: _pageController,
              onPageChanged: (int page) => updateDirection(_pageController),
              children: const <Widget>[
            FirstPage(),
            SecondPage(),
            ThirdPage(),
            LastPage()
          ])),
      const Padding(padding: EdgeInsets.only(top: 50)),
      DotsIndicator(
        dotsCount: _dotsCount,
        position: currentPageIndex,
        decorator: const DotsDecorator(
          color: Colors.black,
          activeColor: Colors.redAccent,
        ),
      ),
      const Padding(padding: EdgeInsets.only(top: 30)),
      ElevatedButton(
          style: style,
          onPressed: () => changePage(_pageController),
          child: Text(_isNext())),
      const Padding(padding: EdgeInsets.only(bottom: 60)),
    ]));
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Image(image: AssetImage("assets/images/poke_ball_icon.png")),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text("A pokedex in your pocket",
                      style: TextStyle(
                          // GoogleFonts.montserrat(),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ])));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 30)),
                Stack(
                  children: const [
                    Opacity(
                      opacity: 0.3,
                      child: Image(
                          image:
                              AssetImage("assets/images/poke_ball_icon.png")),
                    ),
                    Image(image: AssetImage("assets/images/172.png"))
                  ],
                ),
              ])),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Text(
            "Complete database",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text("You can find any Pokemon and information about it",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        ]));
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 30)),
                Stack(
                  children: const [
                    Opacity(
                      opacity: 0.3,
                      child: Image(
                          image:
                              AssetImage("assets/images/poke_ball_icon.png")),
                    ),
                    Image(image: AssetImage("assets/images/25.png"))
                  ],
                ),
              ])),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Text(
            "Habitat location",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text("Lots of information about Pokèmon's favorite habitats and where you can find them",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        ]));
  }
}

class LastPage extends StatelessWidget {
  const LastPage({Key? key}) : super(key: key);

  skipTutorial() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 30)),
                Stack(
                  children: const [
                    Opacity(
                      opacity: 0.3,
                      child: Image(
                          image:
                              AssetImage("assets/images/poke_ball_icon.png")),
                    ),
                    Image(image: AssetImage("assets/images/26.png"))
                  ],
                ),
              ])),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Text(
            "Catching Pokemon",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text("You can sign in and set your favorite  Pokemon to find them better",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        ]));
  }
}
