import 'package:flutter/material.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/Colors/Colors.dart';

import 'package:movies/Constants/Constants.dart';

class DetailsPersonPage extends StatelessWidget {
  const DetailsPersonPage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNav(),
      // body: 
    );
  }
}
