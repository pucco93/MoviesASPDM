import 'package:flutter/material.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/Colors/Colors.dart';

import 'package:movies/Constants/Constants.dart';

class DetailsMoviePage extends StatelessWidget {
  DetailsMoviePage({Key? key, required this.item}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNav(),
      // body: 
    );
  }
}
