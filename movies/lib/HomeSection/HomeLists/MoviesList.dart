import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Movie.dart';

class MoviesList extends StatelessWidget {
  const MoviesList(
      {Key? key,
      required this.movies,
      required this.openItem,
      required this.isLoading})
      : super(key: key);

  final List<dynamic> movies;
  final Function openItem;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Shimmers()
        : movies.isNotEmpty
            ? ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie item = movies[index];
                  return MovieCard(item: item, openItem: openItem);
                },
                scrollDirection: Axis.horizontal,
              )
            : const Text("no data");
  }
}
