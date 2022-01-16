import 'package:flutter/material.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/Colors/Colors.dart';

import 'package:movies/Constants/Constants.dart';
import 'package:provider/provider.dart';

class DetailsSeriePage extends StatefulWidget {
  DetailsSeriePage({Key? key, required this.item}) : super(key: key);
  final dynamic item;

  @override
  State<DetailsSeriePage> createState() => _DetailsSeriePageState();
}

class _DetailsSeriePageState extends State<DetailsSeriePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      // bottomNavigationBar: BottomNav(),
      body: SingleChildScrollView(child: Column(children: [
        
      ])
    ));
  }
}
