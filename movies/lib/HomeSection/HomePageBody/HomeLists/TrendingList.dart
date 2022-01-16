import 'package:flutter/material.dart';
import 'package:movies/Cards/MovieCard.dart';
import 'package:movies/HomeSection/HomePageBody/HomeLists/Shimmers.dart';
import 'package:movies/models/providers/ProviderHome.dart';
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
