import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Providers/ProviderHome.dart';
import 'package:movies/models/interfaces/Movie.dart';
import 'package:provider/provider.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key, required this.type}) : super(key: key);

  final String type;

  _checkLoaderType(ProviderHome homeProvider) {
    switch (type) {
      case "best":
        return homeProvider.isBestMoviesLoading;
      case "popular":
        return homeProvider.isPopularMoviesLoading;
      case "upcoming":
        return homeProvider.isUpcomingMoviesLoading;
    }
  }

  _releaseCorrectList(ProviderHome homeProvider) {
    switch (type) {
      case "best":
        return homeProvider.bestMovies;
      case "popular":
        return homeProvider.popularMovies;
      case "upcoming":
        return homeProvider.upcomingMovies;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return _checkLoaderType(homeProvider)
          ? const Shimmers()
          : _releaseCorrectList(homeProvider).isNotEmpty
              ? ListView.builder(
                  itemCount: _releaseCorrectList(homeProvider).length,
                  itemBuilder: (context, index) {
                    Movie item = _releaseCorrectList(homeProvider)[index];
                    return MovieCard(item: item);
                  },
                  scrollDirection: Axis.horizontal,
                )
              : const Text("no data");
    });
  }
}
