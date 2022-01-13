import 'package:flutter/material.dart';
import 'package:movies/Constants/Constants.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({Key? key, required this.item, required this.openItem})
      : super(key: key);

  final dynamic item;
  final Function openItem;

  _openItem() {
    openItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
            onTap: () => _openItem,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Stack(children: [
                item.posterPath != ""
                    ? FadeInImage.assetNetwork(
                        image: '$basePathImages${item.backdropPath}',
                        placeholder:
                            'assets/images/placeholder_movie.png',
                      )
                    : const Image(
                        image: AssetImage(
                            "assets/images/placeholder_movie.png")),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            )));
  }
}
