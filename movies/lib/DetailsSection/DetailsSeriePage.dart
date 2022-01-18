import 'package:flutter/material.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/Colors/Colors.dart';

import 'package:movies/Constants/Constants.dart';
import 'package:provider/provider.dart';

class DetailsSeriePage extends StatelessWidget {
  const DetailsSeriePage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 75)),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FadeInImage.assetNetwork(
                              placeholder:
                                  'assets/images/placeholder_movie.png',
                              image: '$basePathImages${item.backdropPath}'),
                        ],
                      ))
                ]))));
  }
}
