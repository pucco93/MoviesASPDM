import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Person.dart';

class HorizontalPopularPeopleList extends StatelessWidget {
  const HorizontalPopularPeopleList({Key? key, required this.getPopularPeople, required this.openItem})
      : super(key: key);

  final Function getPopularPeople;
  final Function openItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      builder: (context, peopleSnap) {
        if (peopleSnap.connectionState != ConnectionState.done &&
            peopleSnap.hasData == false) {
          return const Shimmers(); // Shimmer
        }
        List<Person> items =
            Utilities.mapPeople((peopleSnap.data as Map)["results"]);
        return items.isNotEmpty ? ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            Person item = items[index];
            return MovieCard(item: item, openItem: openItem);
          },
          scrollDirection: Axis.horizontal,
        ) : const Text("no data");
      },
      future: getPopularPeople(),
    );
  }
}
