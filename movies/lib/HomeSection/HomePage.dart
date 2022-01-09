import 'package:flutter/material.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsPersonPage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'package:movies/Constants/Constants.dart';

import 'package:movies/SideDrawer/SideDrawer.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/SearchSection/SearchPage.dart';
import 'package:movies/ProfileSection/ProfilePage.dart';
import 'package:movies/FavouritesSection/FavouritesPage.dart';
import 'package:movies/HomeSection/HomeLists/TrendingList.dart';
import 'package:movies/HomeSection/HomeLists/UpcomingMovies.dart';
import 'package:movies/HomeSection/HomeLists/BestMovies.dart';
import 'package:movies/HomeSection/HomeLists/BestSeries.dart';
import 'package:movies/HomeSection/HomeLists/PopularPeople.dart';
import 'package:movies/HomeSection/HomeLists/PopularMovies.dart';
import 'package:movies/HomeSection/HomeLists/PopularSeries.dart';
import 'package:movies/HomeSection/LatestItems/LatestMovies.dart';
import 'package:movies/HomeSection/LatestItems/LatestSeries.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      primary: Colors.redAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ));

  _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  _openProfile() {}

  _closeDrawer() {
    Navigator.pop(context);
  }

  _changeCurrentPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      HomePageBody(),
      const SearchPage(),
      const ProfilePage(),
      const FavouritesPage()
    ];

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            onPressed: _openProfile),
        title: Center(
            child: RichText(
                text: const TextSpan(children: [
          TextSpan(
              text: "Hi",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          TextSpan(text: ", Ale", style: TextStyle(fontSize: 22))
        ]))),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu_rounded, size: 30),
              onPressed: _openDrawer),
          const Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      drawer: NavDrawer(
        closeDrawer: _closeDrawer,
      ),
      body: _pageOptions[currentPageIndex],
      bottomNavigationBar: BottomNav(
          changeCurrentPageIndex: _changeCurrentPageIndex,
          currentPageIndex: currentPageIndex),
    );
  }
}

class HomePageBody extends StatelessWidget {
  HomePageBody({Key? key}) : super(key: key);

  final tmdb = TMDB(
    ApiKeys(v3Token, bearerV4Token),
  );

  Future<Object> getTrendingMovies() async {
    Map result = await tmdb.v3.trending
        .getTrending(mediaType: MediaType.all, timeWindow: TimeWindow.week);
    return result;
  }

  Future<Object> getBestMovies() async {
    Map result = await tmdb.v3.movies.getTopRated(language: "it-IT");
    return result;
  }

  Future<Object> getBestSeries() async {
    Map result = await tmdb.v3.tv.getTopRated(language: "it-IT");
    return result;
  }

  Future<Object> getUpcomingMovies() async {
    Map result =
        await tmdb.v3.movies.getUpcoming(language: "it-IT", region: "IT");
    return result;
  }

  Future<Object> getLatestMovie() async {
    Map result = await tmdb.v3.movies.getLatest(language: "it-IT");
    return result;
  }

  Future<Object> getLatestSerie() async {
    Map result = await tmdb.v3.tv.getLatest(language: "it-IT");
    return result;
  }

  Future<Object> getPopularMovies() async {
    Map result =
        await tmdb.v3.movies.getPouplar(language: "it-IT", region: "IT");
    return result;
  }

  Future<Object> getPopularTVSeries() async {
    Map result = await tmdb.v3.tv.getPouplar(language: "it-IT");
    return result;
  }

  Future<Object> getPopularPeople() async {
    Map result = await tmdb.v3.people.getPopular(language: "it-IT");
    return result;
  }

  @override
  Widget build(BuildContext context) {

  openItem(dynamic item) {
    if (item.mediaType == "movie") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsMoviePage(item: item)));
    } else if (item.mediaType == "tv") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsSeriePage(item: item)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPersonPage(item: item)));}
  }

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
            child: HorizontalTrendingMoviesList(
                getTrendingMovies: getTrendingMovies, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Latest movie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        PreviewLatestMovie(getLatestMovie: getLatestMovie),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child:
                    Text("Upcoming movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalUpcomingMoviesList(
                getUpcomingMovies: getUpcomingMovies, openItem: openItem,)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Best movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalBestMoviesList(getBestMovies: getBestMovies, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Best tv series", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalBestSeriesList(getBestSeries: getBestSeries, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child:
                    Text("Latest TV serie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        PreviewLatestSerie(getLatestSerie: getLatestSerie),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular movies", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalPopularMoviesList(
                getPopularMovies: getPopularMovies, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular series", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalPopularSeriesList(
                getPopularSeries: getPopularTVSeries, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Popular people", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
            height: 220,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: HorizontalPopularPeopleList(
                getPopularPeople: getPopularPeople, openItem: openItem)),
        const Padding(padding: EdgeInsets.only(top: 20)),
      ],
    ));
  }
}
