import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';

class PreviewLatestMovie extends StatelessWidget {
  const PreviewLatestMovie(
      {Key? key, required this.movie, required this.isLoading})
      : super(key: key);

  final Movie movie;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    _openMovie(Movie movie) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsMoviePage(item: movie)));
    }

    return isLoading
        ? const ShimmerMovie()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                        onTap: () => _openMovie(movie),
                        child: Container(
                            height: 300,
                            width: 600,
                            child: Stack(
                              children: [
                                movie.backdropPath != ""
                                    ? FadeInImage.assetNetwork(
                                        image:
                                            '$basePathImages${movie.backdropPath}',
                                        placeholder:
                                            'assets/images/placeholder_movie.png',
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "assets/images/placeholder_movie.png")),
                                Container(
                                  height: 300,
                                  width: 600,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.0),
                                            Colors.black,
                                          ],
                                          stops: const [
                                            0.0,
                                            1.0
                                          ])),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(movie.title,
                                                style: const TextStyle(
                                                    fontSize: 16))))),
                              ],
                            )))),
              ],
            ));
  }
}

class ShimmerMovie extends StatelessWidget {
  const ShimmerMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}