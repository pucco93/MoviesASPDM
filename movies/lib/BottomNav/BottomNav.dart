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
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      boxShadow: [                                                               
      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),       
    ]),
      child: ClipRRect(                                                            
    borderRadius: const BorderRadius.only(                                           
    topLeft: Radius.circular(20.0),                                            
    topRight: Radius.circular(20.0),                                           
    ),                                                                         
    child:BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: ColorSelect.customBlue,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentPageIndex,
      selectedItemColor: ColorSelect.customBlue,
      items: [
        BottomNavigationBarItem(
            label: "Home", icon: Container(
          decoration: BoxDecoration(
              color: currentPageIndex == 0 ? ColorSelect.customMagenta : Colors.transparent,
              shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.home_outlined, size: 30)))),
        BottomNavigationBarItem(
            label: "Search", icon: Container(
          decoration: BoxDecoration(
              color: currentPageIndex == 1 ? ColorSelect.customMagenta : Colors.transparent,
              shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search_outlined, size: 30)))),
        BottomNavigationBarItem(
            label: "Profile",
            icon: Container(
          decoration: BoxDecoration(
              color: currentPageIndex == 2 ? ColorSelect.customMagenta : Colors.transparent,
              shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle_outlined, size: 30)))),
        BottomNavigationBarItem(
            label: "Favourites",
            icon: Container(
          decoration: BoxDecoration(
              color: currentPageIndex == 3 ? ColorSelect.customMagenta : Colors.transparent,
              shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_outline_outlined, size: 30)))),
      ],
      onTap: (index) => _changeCurrentPageIndex(index),
    )));
  }
}
