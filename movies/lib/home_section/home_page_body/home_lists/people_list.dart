import 'package:flutter/material.dart';
import 'package:movies/cards/movie_card.dart';
import 'package:movies/home_section/home_page_body/home_lists/shimmers.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:movies/models/interfaces/person.dart';
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
