import 'package:flutter/material.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsPersonPage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:provider/provider.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  _openItem(BuildContext context, dynamic item) {
    if (item.mediaType == "movie") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsMoviePage(item: item)));
      } else if (item.mediaType == "tv") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsSeriePage(item: item)));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPersonPage(item: item)));
      }
  }

  _checkImages(dynamic item) {
    if (item.mediaType == "person" && item.posterPath != "") {
      return true;
    } else if (item.mediaType == "movie" && item.backdropPath != "") {
      return true;
    } else if (item.mediaType == "tv" && item.backdropPath != "") {
      return true;
    }
    return false;
  }

  _renderCorrectImage(dynamic item) {
    return item.mediaType == "movie"
        ? '$basePathImages${item.backdropPath}'
        : item.mediaType == "tv"
            ? '$basePathImages${item.backdropPath}'
            : '$basePathImages${item.posterPath}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, searchProvider, child) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                  onTap: () => _openItem(context, item),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    child: Stack(children: [
                      _checkImages(item)
                          ? FadeInImage.assetNetwork(
                              height: 200,
                              width: 200,
                              alignment: Alignment.topCenter,
                              image: _renderCorrectImage(item),
                              placeholder:
                                  'assets/images/placeholder_movie.png',
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              child:
                          const FittedBox(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/placeholder_movie.png")),
                              fit: BoxFit.cover,
                            )),
                      Container(
                        height: 200,
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
                                  child: Text(
                                      item.mediaType == "tv" ||
                                              item.mediaType == "person"
                                          ? item.name
                                          : item.title,
                                      style: const TextStyle(fontSize: 16))))),
                    ], fit: StackFit.loose),
                  ))));
    });
  }
}
