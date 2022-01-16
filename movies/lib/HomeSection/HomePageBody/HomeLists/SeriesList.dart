import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomePageBody/HomeLists/Shimmers.dart';
import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:provider/provider.dart';

class SeriesList extends StatelessWidget {
  SeriesList({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return (type == "best" ? homeProvider.isBestSeriesLoading : homeProvider.isPopularSeriesLoading)
          ? const Shimmers()
          : (type == "best" ? homeProvider.bestSeries.isNotEmpty : homeProvider.popularSeries.isNotEmpty)
              ? ListView.builder(
                  itemCount: (type == "best" ? homeProvider.bestSeries.length : homeProvider.popularSeries.length),
                  itemBuilder: (context, index) {
                    TVSerie item = (type == "best" ? homeProvider.bestSeries[index] : homeProvider.popularSeries[index]);
                    return MovieCard(item: item);
                  },
                  scrollDirection: Axis.horizontal,
                )
              : const Text("no data");
    });
  }
}
