import 'package:flutter/material.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/TVSerie.dart';
import 'package:movies/Constants/Constants.dart';

class PreviewLatestSerie extends StatelessWidget {
  const PreviewLatestSerie({Key? key, required this.serie, required this.isLoading})
      : super(key: key);

  final TVSerie serie;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    _openSerie(TVSerie serie) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsSeriePage(item: serie)));
    }

    return isLoading ? const ShimmerSerie() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                        onTap: () => _openSerie(serie),
                        child: Container(
                            height: 300,
                            width: 600,
                            child: Stack(
                              children: [
                serie.backdropPath != ""
                    ? FadeInImage.assetNetwork(
                        image: '$basePathImages${serie.backdropPath}',
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
                                            child: Text(serie.name,
                                                style: const TextStyle(
                                                    fontSize: 16))))),
                              ],
                            )))),
              ],
            ));
      }
}

class ShimmerSerie extends StatelessWidget {
  const ShimmerSerie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}