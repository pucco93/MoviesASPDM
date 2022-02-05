import 'package:flutter/material.dart';
import 'package:movies/Cards/movie_card.dart';
import 'package:movies/home_section/home_page_body/home_lists/shimmers.dart';
import 'package:movies/models/providers/provider_home.dart';
import 'package:provider/provider.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return homeProvider.isTrendingLoading
          ? const Shimmers()
          : homeProvider.trendingItems.isNotEmpty
              ? ListView.builder(
                  itemCount: homeProvider.trendingItems.length,
                  itemBuilder: (context, index) {
                    dynamic item = homeProvider.trendingItems[index];
                    return MovieCard(item: item);
                  },
                  scrollDirection: Axis.horizontal,
                )
              : const Text("no data");
    });
  }
}
