import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomeLists/Shimmers.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/models/Providers/ProviderHome.dart';
import 'package:movies/models/interfaces/Person.dart';
import 'package:provider/provider.dart';

class PeopleList extends StatelessWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return homeProvider.isPeopleLoading
          ? const Shimmers()
          : homeProvider.people.isNotEmpty
              ? ListView.builder(
                  itemCount: homeProvider.people.length,
                  itemBuilder: (context, index) {
                    Person item = homeProvider.people[index];
                    return MovieCard(item: item);
                  },
                  scrollDirection: Axis.horizontal,
                )
              : const Text("no data");
    });
  }
}
