import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/Utilities/Utilities.dart';
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

  _getTrending(ProviderHome homeProvider, [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<dynamic> newTrendingItems = [];
    if (_dataBox.get("trending") ?? true && forceRefresh == false) {
      newTrendingItems =
          Utilities.fromHiveToDataGenericItem(_dataBox.get("trending"));
    } else {
      newTrendingItems = await dataManager.getTrending();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "trending", Utilities.fromDataToHiveGenericItem(newTrendingItems));
    }
    homeProvider.updateTrendingItems(newTrendingItems);
  }

  _getUpcomingMovies(ProviderHome homeProvider,
      [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<Movie> newUpcomingMovies = [];
    if (_dataBox.get("upcomingmovies") ?? true && forceRefresh == false) {
      newUpcomingMovies =
          Utilities.fromHiveToDataMovies(_dataBox.get("upcomingmovies"));
    } else {
      newUpcomingMovies = await dataManager.getUpcomingMovies();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "upcomingmovies", Utilities.fromDataToHiveMovies(newUpcomingMovies));
    }
    homeProvider.updateUpcomingMovies(newUpcomingMovies);
  }

  _getLatestMovie(ProviderHome homeProvider,
      [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    Movie newLatestMovie = initialMovie;
    if (_dataBox.get("newlatestmovie") ?? true && forceRefresh == false) {
      newLatestMovie =
          Utilities.fromHiveToDataMovie(_dataBox.get("newlatestmovie"));
    } else {
      newLatestMovie = await dataManager.getLatestMovie();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "newlatestmovie", Utilities.fromDataToHiveMovie(newLatestMovie));
    }
    homeProvider.updateLatestMovie(newLatestMovie);
  }

  _getLatestSerie(ProviderHome homeProvider,
      [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    TVSerie newLatestSerie = initialSerie;
    if (_dataBox.get("latestserie") ?? true && forceRefresh == false) {
      newLatestSerie =
          Utilities.fromHiveToDataSerie(_dataBox.get("latestserie"));
    } else {
      TVSerie newLatestSerie = await dataManager.getLatestSerie();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "latestserie", Utilities.fromDataToHiveSerie(newLatestSerie));
    }
    homeProvider.updateLatestSerie(newLatestSerie);
  }

  _getPopularMovies(ProviderHome homeProvider,
      [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<Movie> newPopularMovies = [];
    if (_dataBox.get("popularmovies") ?? true && forceRefresh == false) {
      newPopularMovies =
          Utilities.fromHiveToDataMovies(_dataBox.get("popularmovies"));
    } else {
      newPopularMovies = await dataManager.getPopularMovies();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "popularmovies", Utilities.fromDataToHiveMovies(newPopularMovies));
    }
    homeProvider.updatePopularMovies(newPopularMovies);
  }

  _getPopularSeries(ProviderHome homeProvider,
      [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<TVSerie> newPopularSeries = [];
    if (_dataBox.get("popularseries") ?? true && forceRefresh == false) {
      newPopularSeries =
          Utilities.fromHiveToDataSeries(_dataBox.get("popularseries"));
    } else {
      newPopularSeries = await dataManager.getPopularTVSeries();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "popularseries", Utilities.fromDataToHiveSeries(newPopularSeries));
    }
    homeProvider.updatePopularSeries(newPopularSeries);
  }

  _getBestMovies(ProviderHome homeProvider, [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<Movie> newBestMovies = [];
    if (_dataBox.get("bestmovies") ?? true && forceRefresh == false) {
      newBestMovies =
          Utilities.fromHiveToDataMovies(_dataBox.get("bestmovies"));
    } else {
      newBestMovies = await dataManager.getBestMovies();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "bestmovies", Utilities.fromDataToHiveMovies(newBestMovies));
    }
    homeProvider.updateBestMovies(newBestMovies);
  }

  _getBestSeries(ProviderHome homeProvider, [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<TVSerie> newBestSeries = [];
    if (_dataBox.get("bestseries") ?? true && forceRefresh == false) {
      newBestSeries =
          Utilities.fromHiveToDataSeries(_dataBox.get("bestseries"));
    } else {
      newBestSeries = await dataManager.getBestSeries();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put(
          "bestseries", Utilities.fromDataToHiveSeries(newBestSeries));
    }
    homeProvider.updateBestSeries(newBestSeries);
  }

  _getPeople(ProviderHome homeProvider, [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<Person> newPeople = [];
    if (_dataBox.get("people") ?? true && forceRefresh == false) {
      newPeople = Utilities.fromHiveToDataPeople(_dataBox.get("people"));
    } else {
      newPeople = await dataManager.getPopularPeople();
      String timestamp = DateTime.now().toIso8601String();
      await _dataBox.put("last_timestamp", timestamp);
      await _dataBox.put("people", Utilities.fromDataToHivePeople(newPeople));
    }
    homeProvider.updatePeople(newPeople);
  }

  Future<void> _pullRefresh(ProviderHome homeProvider) async {
    _getTrending(homeProvider, true);
    _getBestMovies(homeProvider, true);
    _getBestSeries(homeProvider, true);
    _getLatestMovie(homeProvider, true);
    _getLatestSerie(homeProvider, true);
    _getPeople(homeProvider, true);
    _getPopularMovies(homeProvider, true);
    _getPopularSeries(homeProvider, true);
    _getUpcomingMovies(homeProvider, true);
  }

  @override
  void initState() {
    ProviderHome homeProvider =
        Provider.of<ProviderHome>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getTrending(homeProvider);
      _getUpcomingMovies(homeProvider);
      _getBestMovies(homeProvider);
      _getBestSeries(homeProvider);
      _getLatestMovie(homeProvider);
      _getLatestSerie(homeProvider);
      _getPopularMovies(homeProvider);
      _getPopularSeries(homeProvider);
      _getPeople(homeProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return RefreshIndicator(
          onRefresh: () => _pullRefresh(homeProvider),
          child: SingleChildScrollView(
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
                      child: Text("Latest movie",
                          style: TextStyle(fontSize: 20)))),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const PreviewLatestMovie(),
              const Padding(padding: EdgeInsets.only(top: 30)),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Upcoming movies",
                          style: TextStyle(fontSize: 20)))),
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
                      child:
                          Text("Best movies", style: TextStyle(fontSize: 20)))),
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
                      child: Text("Best tv series",
                          style: TextStyle(fontSize: 20)))),
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
                      child: Text("Latest TV serie",
                          style: TextStyle(fontSize: 20)))),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const PreviewLatestSerie(),
              const Padding(padding: EdgeInsets.only(top: 30)),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Popular movies",
                          style: TextStyle(fontSize: 20)))),
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
                      child: Text("Popular series",
                          style: TextStyle(fontSize: 20)))),
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
                      child: Text("Popular people",
                          style: TextStyle(fontSize: 20)))),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                  height: 220,
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: const PeopleList()),
              const Padding(padding: EdgeInsets.only(top: 90)),
            ],
          )));
    });
  }
}
