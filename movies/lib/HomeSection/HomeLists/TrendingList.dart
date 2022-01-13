import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';

class HorizontalTrendingMoviesList extends StatelessWidget {
  const HorizontalTrendingMoviesList(
      {Key? key,
      required this.items,
      required this.openItem,
      required this.isLoading})
      : super(key: key);

  final List<dynamic> items;
  final Function openItem;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading ? const Shimmers() : items.isNotEmpty
        ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              dynamic item = items[index];
              return MovieCard(item: item, openItem: openItem);
            },
            scrollDirection: Axis.horizontal,
          )
        : const Text("no data");
  }
}
