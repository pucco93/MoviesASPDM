import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/models/providers/ProviderSearch.dart';
import 'package:provider/provider.dart';
import 'GridItemShimmer.dart';
import 'GridViewCard/GridViewCard.dart';

class GridViewSearch extends StatelessWidget {
  const GridViewSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSearch>(builder: (context, searchProvider, child) {
      return searchProvider.isLoading ? const GridViewShimmer() : GridView.builder(
          padding: const EdgeInsets.only(top: 15, bottom: 80),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: searchProvider.searchedItems.length,
          itemBuilder: (context, index) {
            return searchProvider.searchedItems.isNotEmpty
                    ? GridViewCard(item: searchProvider.searchedItems[index])
                    : const NoElementsFound();
          });
    });
  }
}

class NoElementsFound extends StatelessWidget {
  const NoElementsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Consumer<ProviderSearch>(
                builder: (context, searchProvider, child) {
              return Text(
                  "No element found searching for ${searchProvider.searchText}");
            })));
  }
}
