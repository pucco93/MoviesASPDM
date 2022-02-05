import 'package:flutter/material.dart';
import 'package:movies/Cards/movie_card.dart';
import 'package:movies/home_section/home_page_body/home_lists/shimmers.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:movies/models/interfaces/tv_serie.dart';
import 'package:provider/provider.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({Key? key, required this.type}) : super(key: key);
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
