import 'package:flutter/material.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:provider/provider.dart';

class PreviewLatestSerie extends StatelessWidget {
  const PreviewLatestSerie(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _openSerie(TVSerie serie) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsSeriePage(item: serie)));
    }

    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return homeProvider.isLatestSerieLoading
          ? const ShimmerSerie()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                          onTap: () => _openSerie(homeProvider.latestSerie),
                          child: Container(
                              height: 300,
                              width: 600,
                              child: Stack(
                                children: [
                                  homeProvider.latestSerie.backdropPath != ""
                                      ? FadeInImage.assetNetwork(
                                          image:
                                              '$basePathImages${homeProvider.latestSerie.backdropPath}',
                                          placeholder:
                                              'assets/images/placeholder_movie.png',
                                          fit: BoxFit.cover)
                                      : Container(
                                          height: 300,
                                          width: 600,
                                          child: const FittedBox(
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/images/placeholder_movie.png")),
                                              fit: BoxFit.cover)),
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
                                              child: Text(homeProvider.latestSerie.name,
                                                  style: const TextStyle(
                                                      fontSize: 16))))),
                                ],
                              )))),
                ],
              ));
    });
  }
}

class ShimmerSerie extends StatelessWidget {
  const ShimmerSerie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
