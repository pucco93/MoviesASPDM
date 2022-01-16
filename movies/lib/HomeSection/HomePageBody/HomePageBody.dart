import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies/data_manager/DataManager.dart';

import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/Person.dart';
import 'package:movies/models/interfaces/TVSerie.dart';

import 'package:movies/HomeSection/HomePageBody/HomeLists/TrendingList.dart';
import 'package:movies/HomeSection/HomePageBody/HomeLists/MoviesList.dart';
import 'package:movies/HomeSection/HomePageBody/HomeLists/SeriesList.dart';
import 'package:movies/HomeSection/HomePageBody/HomeLists/PeopleList.dart';
import 'package:movies/HomeSection/HomePageBody/LatestItems/LatestMovies.dart';
import 'package:movies/HomeSection/HomePageBody/LatestItems/LatestSeries.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  DataManager dataManager = DataManager();

  _getTrending(ProviderHome homeProvider) async {
    List<dynamic> newTrendingItems = await dataManager.getTrending();
    homeProvider.updateTrendingItems(newTrendingItems);
  }

  _getUpcomingMovies(ProviderHome homeProvider) async {
    List<Movie> newUpcomingMovies = await dataManager.getUpcomingMovies();
    homeProvider.updateUpcomingMovies(newUpcomingMovies);
  }

  _getLatestMovie(ProviderHome homeProvider) async {
    Movie newLatestMovie = await dataManager.getLatestMovie();
    homeProvider.updateLatestMovie(newLatestMovie);
  }

  _getLatestSerie(ProviderHome homeProvider) async {
    TVSerie newLatestSerie = await dataManager.getLatestSerie();
    homeProvider.updateLatestSerie(newLatestSerie);
  }

  _getPopularMovies(ProviderHome homeProvider) async {
    List<Movie> newPopularMovies = await dataManager.getPopularMovies();
    homeProvider.updatePopularMovies(newPopularMovies);
  }

  _getPopularSeries(ProviderHome homeProvider) async {
    List<TVSerie> newPopularSeries = await dataManager.getPopularTVSeries();
    homeProvider.updatePopularSeries(newPopularSeries);
  }

  _getBestMovies(ProviderHome homeProvider) async {
    List<Movie> newBestMovies = await dataManager.getBestMovies();
    homeProvider.updateBestMovies(newBestMovies);
  }

  _getBestSeries(ProviderHome homeProvider) async {
    List<TVSerie> newBestSeries = await dataManager.getBestSeries();
    homeProvider.updateBestSeries(newBestSeries);
  }

  _getPeople(ProviderHome homeProvider) async {
    List<Person> newPeople = await dataManager.getPopularPeople();
    homeProvider.updatePeople(newPeople);
  }

  @override
  void initState() {
    ProviderHome homeProvider =
        Provider.of<ProviderHome>(context, listen: false);
    _getTrending(homeProvider);
    _getUpcomingMovies(homeProvider);
    _getBestMovies(homeProvider);
    _getBestSeries(homeProvider);
    _getLatestMovie(homeProvider);
    _getLatestSerie(homeProvider);
    _getPopularMovies(homeProvider);
    _getPopularSeries(homeProvider);
    _getPeople(homeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 95)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Trending", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const TrendingList()),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Latest movie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        const PreviewLatestMovie(),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child:
                    Text("Upcoming movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const MoviesList(type: "upcoming")),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Best movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const MoviesList(type: "best")),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Best tv series", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: SeriesList(type: "best")),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child:
                    Text("Latest TV serie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        const PreviewLatestSerie(),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const MoviesList(type: "popular")),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular series", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: SeriesList(type: "popular")),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular people", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: const PeopleList()),
        const Padding(padding: EdgeInsets.only(top: 90)),
      ],
    )
  );
  }
}