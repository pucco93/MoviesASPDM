import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/TVSerie.dart';

class HorizontalBestSeriesList extends StatelessWidget {
  const HorizontalBestSeriesList({Key? key, required this.getBestSeries, required this.openItem})
      : super(key: key);

  final Function getBestSeries;
  final Function openItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      builder: (context, movieSnap) {
        if (movieSnap.connectionState != ConnectionState.done &&
            movieSnap.hasData == false) {
          return const Shimmers(); // Shimmer
        }
        List<TVSerie> items =
            Utilities.mapTVSeries((movieSnap.data as Map)["results"]);
        return items.isNotEmpty ? ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            TVSerie item = items[index];
            return MovieCard(item: item, openItem: openItem);
          },
          scrollDirection: Axis.horizontal,
        ) : const Text("no data");
      },
      future: getBestSeries(),
    );
  }
}
