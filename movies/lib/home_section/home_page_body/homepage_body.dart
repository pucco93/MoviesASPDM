import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/Utilities/utilities.dart';
import 'package:movies/utilities/device_info.dart';
import 'package:provider/provider.dart';

import 'package:movies/data_manager/data_manager.dart';

import 'package:movies/models/providers/provider_home.dart';
import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/models/interfaces/person.dart';
import 'package:movies/models/interfaces/tv_serie.dart';

import 'package:movies/home_section/home_page_body/home_lists/trending_list.dart';
import 'package:movies/home_section/home_page_body/home_lists/movies_list.dart';
import 'package:movies/home_section/home_page_body/home_lists/series_list.dart';
import 'package:movies/home_section/home_page_body/home_lists/people_list.dart';
import 'package:movies/home_section/home_page_body/latest_items/latest_movies.dart';
import 'package:movies/home_section/home_page_body/latest_items/latest_series.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  DataManager dataManager = DataManager();
  DeviceInfo deviceInfo = DeviceInfo();
  bool _isIPhoneNotch = false;

  _getTrending(ProviderHome homeProvider, [bool forceRefresh = false]) async {
    final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    List<dynamic> newTrendingItems = [];
    if (forceRefresh == false && _dataBox.get("trending") != null) {
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
    if (forceRefresh == false && _dataBox.get("upcomingmovies") != null) {
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
    if (forceRefresh == false && _dataBox.get("newlatestmovie") != null) {
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
    if (forceRefresh == false && _dataBox.get("latestserie") != null) {
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
    if (forceRefresh == false && _dataBox.get("popularmovies") != null) {
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
    if (forceRefresh == false && _dataBox.get("popularseries") != null) {
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
    if (forceRefresh == false && _dataBox.get("bestmovies") != null) {
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
    if (forceRefresh == false && _dataBox.get("bestseries") != null) {
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
    if (forceRefresh == false && _dataBox.get("people") != null) {
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

  Future<void> _getDeviceInfo() async {
    _isIPhoneNotch = await deviceInfo.isIPhoneNotch();
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
    _getDeviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    // final Box<dynamic> _dataBox = Hive.box<dynamic>("dataBox");
    // _dataBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHome>(builder: (context, homeProvider, child) {
      return RefreshIndicator(
          onRefresh: () => _pullRefresh(homeProvider),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: _isIPhoneNotch ? 115 : 95)),
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
                  child: const SeriesList(type: "best")),
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
                  child: const SeriesList(type: "popular")),
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
              Padding(padding: EdgeInsets.only(top: _isIPhoneNotch ? 115 : 95)),
            ],
          )));
    });
  }
}
