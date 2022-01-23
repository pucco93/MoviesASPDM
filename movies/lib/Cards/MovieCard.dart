import 'package:flutter/material.dart';

import 'package:movies/Constants/Constants.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsPersonPage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.item})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                    onTap: () => _openItem(context, item),
                    child: Container(
                        height: 220,
                        width: 145,
                        child: Stack(
                          children: [
                            item?.posterPath != ""
                                ? FadeInImage.assetNetwork(
                                    image: '$basePathImages${item.posterPath}',
                                    placeholder:
                                        'assets/images/movie_poster_placeholder.jpeg',
                                        fit: BoxFit.cover
                                  )
                                : Container(
                                          height: 220,
                                          width: 145,
                                          child: const FittedBox(child: Image(
                                    image: AssetImage(
                                        "assets/images/movie_poster_placeholder.jpeg"),fit: BoxFit.cover,))),
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        const Color.fromARGB(255, 30, 30, 30),
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
                                            style: const TextStyle(
                                                fontSize: 16))))),
                          ],
                        )))),
          ],
        ));
  }
}
