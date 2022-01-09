import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/TVSerie.dart';

class HorizontalPopularSeriesList extends StatelessWidget {
  const HorizontalPopularSeriesList({Key? key, required this.getPopularSeries, required this.openItem})
      : super(key: key);

  final Function getPopularSeries;
  final Function openItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      builder: (context, seriesSnap) {
        if (seriesSnap.connectionState != ConnectionState.done &&
            seriesSnap.hasData == false) {
          return const Shimmers(); // Shimmer
        }
        List<TVSerie> items =
            Utilities.mapTVSeries((seriesSnap.data as Map)["results"]);
        return items.isNotEmpty ? ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            TVSerie item = items[index];
            return MovieCard(item: item, openItem: openItem);
          },
          scrollDirection: Axis.horizontal,
        ) : const Text("no data");
      },
      future: getPopularSeries(),
    );
  }
}
