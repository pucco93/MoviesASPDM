import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'GridItemShimmer.dart';
import 'GridViewCard/GridViewCard.dart';

class GridViewSearch extends StatelessWidget {
  const GridViewSearch(
      {Key? key,
      required this.searchedItems,
      required this.openItem,
      required this.searchItems,
      required this.isLoading})
      : super(key: key);

  final List<dynamic> searchedItems;
  final Function openItem;
  final Function searchItems;
  final bool isLoading;

  _searchItems() {
    searchItems();
  }

  _openItem() {
    openItem();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: (searchedItems.length) != null ? searchedItems.length : 0,
        itemBuilder: (context, index) {
          return isLoading
              ? GridViewShimmer()
              : GridViewCard(item: searchedItems[index], openItem: _openItem);
        });
  }
}
