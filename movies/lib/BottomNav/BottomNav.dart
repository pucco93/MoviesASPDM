import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav(
      {Key? key,
      required this.changeCurrentPageIndex,
      required this.currentPageIndex})
      : super(key: key);

  final ValueChanged<int> changeCurrentPageIndex;
  final int currentPageIndex;

  _changeCurrentPageIndex(int index) {
    changeCurrentPageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentPageIndex,
      selectedItemColor: ColorSelect.customSalmon,
      items: const [
        BottomNavigationBarItem(
            label: "Home", icon: Icon(Icons.home_outlined, size: 30)),
        BottomNavigationBarItem(
            label: "Search", icon: Icon(Icons.search_outlined, size: 30)),
        BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle_outlined, size: 30)),
        BottomNavigationBarItem(
            label: "Favourites",
            icon: Icon(Icons.favorite_outline_outlined, size: 30)),
      ],
      onTap: (index) => _changeCurrentPageIndex(index),
    );
  }
}
