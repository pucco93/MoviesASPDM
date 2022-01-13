import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsPersonPage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/models/Person.dart';
import 'package:movies/models/TVSerie.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'package:movies/Constants/Constants.dart';

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
      const SearchPage(),
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
      body: _pageOptions[currentPageIndex],
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
  bool isTrendingLoading = true;
  bool isBestMoviesLoading = true;
  bool isBestSeriesLoading = true;
  bool isUpcomingMoviesLoading = true;
  bool isPopularMoviesLoading = true;
  bool isPopularSeriesLoading = true;
  bool isPeopleLoading = true;
  bool isLatestSerieLoading = true;
  bool isLatestMovieLoading = true;
  List<dynamic> trendingItems = [];
  List<Movie> bestMovies = [];
  List<TVSerie> bestSeries = [];
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
  List<TVSerie> popularSeries = [];
  List<Person> people = [];
  TVSerie latestSerie = initialSerie;
  Movie latestMovie = initialMovie;

  updateTrendingLoader() {
    if (mounted) {
      setState(() {
        isTrendingLoading = !isTrendingLoading;
      });
    }
  }

  updateUpcomingLoader() {
    if (mounted) {
      setState(() {
        isUpcomingMoviesLoading = !isUpcomingMoviesLoading;
      });
    }
  }

  updateLatestMovieLoader() {
    if (mounted) {
      setState(() {
        isLatestMovieLoading = !isLatestMovieLoading;
      });
    }
  }

  updateLatestSerieLoader() {
    if (mounted) {
      setState(() {
        isLatestSerieLoading = !isLatestSerieLoading;
      });
    }
  }

  updatePopularMoviesLoader() {
    if (mounted) {
      setState(() {
        isPopularMoviesLoading = !isPopularMoviesLoading;
      });
    }
  }

  updatePopularSeriesLoader() {
    if (mounted) {
      setState(() {
        isPopularSeriesLoading = !isPopularSeriesLoading;
      });
    }
  }

  updateBestMoviesLoader() {
    if (mounted) {
      setState(() {
        isBestMoviesLoading = !isBestMoviesLoading;
      });
    }
  }

  updateBestSeriesLoader() {
    if (mounted) {
      setState(() {
        isBestSeriesLoading = !isBestSeriesLoading;
      });
    }
  }

  updatePeopleLoader() {
    if (mounted) {
      setState(() {
        isPeopleLoading = !isPeopleLoading;
      });
    }
  }

  _getTrending() async {
    List<dynamic> newTrendingItems = await dataManager.getTrending();
    if (mounted) {
      setState(() {
        trendingItems = newTrendingItems;
      });
    }
    updateTrendingLoader();
  }

  _getUpcomingMovies() async {
    List<Movie> newUpcomingMovies = await dataManager.getUpcomingMovies();
    if (mounted) {
      setState(() {
        upcomingMovies = newUpcomingMovies;
      });
    }
    updateUpcomingLoader();
  }

  _getLatestMovie() async {
    Movie newLatestMovie = await dataManager.getLatestMovie();
    if (mounted) {
      setState(() {
        latestMovie = newLatestMovie;
      });
    }
    updateLatestMovieLoader();
  }

  _getLatestSerie() async {
    TVSerie newLatestSerie = await dataManager.getLatestSerie();
    if (mounted) {
      setState(() {
        latestSerie = newLatestSerie;
      });
    }
    updateLatestSerieLoader();
  }

  _getPopularMovies() async {
    List<Movie> newPopularMovies = await dataManager.getPopularMovies();
    if (mounted) {
      setState(() {
        popularMovies = newPopularMovies;
      });
    }
    updatePopularMoviesLoader();
  }

  _getPopularSeries() async {
    List<TVSerie> newPopularSeries = await dataManager.getPopularTVSeries();
    if (mounted) {
      setState(() {
        popularSeries = newPopularSeries;
      });
    }
    updatePopularSeriesLoader();
  }

  _getBestMovies() async {
    List<Movie> newBestMovies = await dataManager.getBestMovies();
    if (mounted) {
      setState(() {
        bestMovies = newBestMovies;
      });
    }
    updateBestMoviesLoader();
  }

  _getBestSeries() async {
    List<TVSerie> newBestSeries = await dataManager.getBestSeries();
    if (mounted) {
      setState(() {
        bestSeries = newBestSeries;
      });
    }
    updateBestSeriesLoader();
  }

  _getPeople() async {
    List<Person> newPeople = await dataManager.getPopularPeople();
    if (mounted) {
      setState(() {
        people = newPeople;
      });
    }
    updatePeopleLoader();
  }

  @override
  void initState() {
    super.initState();
    _getTrending();
    _getUpcomingMovies();
    _getBestMovies();
    _getBestSeries();
    _getLatestMovie();
    _getLatestSerie();
    _getPopularMovies();
    _getPopularSeries();
    _getPeople();
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
            child: HorizontalTrendingMoviesList(
              items: trendingItems,
              openItem: openItem,
              isLoading: isTrendingLoading,
            )),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Latest movie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        PreviewLatestMovie(movie: latestMovie, isLoading: isLatestMovieLoading),
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
            child: MoviesList(
                movies: upcomingMovies,
                openItem: openItem,
                isLoading: isUpcomingMoviesLoading)),
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
            child: MoviesList(
                movies: bestMovies,
                openItem: openItem,
                isLoading: isBestMoviesLoading)),
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
            child: SeriesList(
                series: bestSeries,
                openItem: openItem,
                isLoading: isBestSeriesLoading)),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child:
                    Text("Latest TV serie", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 20)),
        PreviewLatestSerie(serie: latestSerie, isLoading: isLatestSerieLoading),
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
            child: MoviesList(
                movies: popularMovies,
                openItem: openItem,
                isLoading: isPopularMoviesLoading)),
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
            child: SeriesList(
                series: popularSeries,
                openItem: openItem,
                isLoading: isPopularSeriesLoading)),
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
            child: PeopleList(
                people: people,
                openItem: openItem,
                isLoading: isPeopleLoading)),
        const Padding(padding: EdgeInsets.only(top: 80)),
      ],
    ));
  }
}
