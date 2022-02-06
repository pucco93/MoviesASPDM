import 'package:flutter/material.dart';
import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/details_section/details_movie_page.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:provider/provider.dart';

class PreviewLatestMovie extends StatelessWidget {
  const PreviewLatestMovie({Key? key}) : super(key: key);

  _openMovie(Movie movie, context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailsMoviePage(item: movie)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return homeProvider.isLatestMovieLoading
          ? const ShimmerMovie()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                          onTap: () =>
                              _openMovie(homeProvider.latestMovie, context),
                          child: SizedBox(
                              height: 300,
                              width: 600,
                              child: Stack(
                                children: [
                                  homeProvider.latestMovie.backdropPath != ""
                                      ? FadeInImage.assetNetwork(
                                          height: 300,
                                          width: 600,
                                          image:
                                              '$basePathImages${homeProvider.latestMovie.backdropPath}',
                                          placeholder:
                                              'assets/images/placeholder_movie.png',
                                          fit: BoxFit.cover)
                                      : const SizedBox(
                                          height: 300,
                                          width: 600,
                                          child: FittedBox(
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/images/placeholder_movie.png")),
                                            fit: BoxFit.cover,
                                          )),
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
                                              Colors.black87,
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
                                              child: Text(
                                                  homeProvider
                                                      .latestMovie.title,
                                                  style: const TextStyle(
                                                      fontSize: 16, color: Colors.white))))),
                                ],
                              )))),
                ],
              ));
    });
  }
}

class ShimmerMovie extends StatelessWidget {
  const ShimmerMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
