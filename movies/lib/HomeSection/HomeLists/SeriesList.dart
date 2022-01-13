import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/TVSerie.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({Key? key, required this.series, required this.openItem, required this.isLoading})
      : super(key: key);

  final List<TVSerie> series;
  final Function openItem;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Shimmers()
        : series.isNotEmpty
            ? ListView.builder(
                itemCount: series.length,
                itemBuilder: (context, index) {
                  TVSerie item = series[index];
                  return MovieCard(item: item, openItem: openItem);
                },
                scrollDirection: Axis.horizontal,
              )
            : const Text("no data");
  }
}
