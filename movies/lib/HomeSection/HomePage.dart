import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsPersonPage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/providers/ProviderFavs.dart';
import 'package:movies/models/providers/ProviderHome.dart';
import 'package:movies/models/providers/ProviderSearch.dart';
import 'package:movies/models/providers/ProviderAccount.dart';
import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/Person.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:provider/provider.dart';

import 'package:movies/SideDrawer/SideDrawer.dart';
import 'package:movies/BottomNav/BottomNav.dart';
import 'package:movies/SearchSection/SearchPage.dart';
import 'package:movies/ProfileSection/ProfilePage.dart';
import 'package:movies/FavouritesSection/FavouritesPage.dart';
import 'package:movies/HomeSection/HomeLists/TrendingList.dart';
import 'package:movies/HomeSection/HomeLists/MoviesList.dart';
import 'package:movies/HomeSection/HomeLists/SeriesList.dart';
import 'package:movies/HomeSection/HomeLists/PeopleList.dart';
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
      SearchPage(),
      const ProfilePage(),
      const FavouritesPage(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: ColorSelect.customBlue,
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
      body: MultiProvider(providers: [
        Provider<ProviderSearch>(create: (context) => ProviderSearch()),
        Provider<ProviderHome>(create: (context) => ProviderHome()),
        Provider<ProviderAccount>(create: (context) => ProviderAccount()),
        Provider<ProviderFavs>(create: (context) => ProviderFavs())
      ], child: _pageOptions[currentPageIndex]),
      bottomNavigationBar: BottomNav(
          changeCurrentPageIndex: _changeCurrentPageIndex,
          currentPageIndex: currentPageIndex),
    );
  }
}

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
                builder: (context) => DetailsPersonPage(item: item)));
      }
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
