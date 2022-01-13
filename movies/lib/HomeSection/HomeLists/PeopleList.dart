import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Person.dart';

class PeopleList extends StatelessWidget {
  const PeopleList(
      {Key? key,
      required this.people,
      required this.openItem,
      required this.isLoading})
      : super(key: key);

  final List<Person> people;
  final Function openItem;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Shimmers()
        : people.isNotEmpty
            ? ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  Person item = people[index];
                  return MovieCard(item: item, openItem: openItem);
                },
                scrollDirection: Axis.horizontal,
              )
            : const Text("no data");
  }
}
