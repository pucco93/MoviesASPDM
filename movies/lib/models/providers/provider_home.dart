import 'package:flutter/material.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/models/interfaces/person.dart';
import 'package:movies/models/interfaces/tv_serie.dart';

class ProviderHome extends ChangeNotifier {
  int _currentPageIndex = 0;
  bool _isTrendingLoading = true;
  bool _isBestMoviesLoading = true;
  bool _isBestSeriesLoading = true;
  bool _isUpcomingMoviesLoading = true;
  bool _isPopularMoviesLoading = true;
  bool _isPopularSeriesLoading = true;
  bool _isPeopleLoading = true;
  bool _isLatestSerieLoading = true;
  bool _isLatestMovieLoading = true;
  List<dynamic> _trendingItems = [];
  List<Movie> _bestMovies = [];
  List<TVSerie> _bestSeries = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _popularMovies = [];
  List<TVSerie> _popularSeries = [];
  List<Person> _people = [];
  TVSerie _latestSerie = initialSerie;
  Movie _latestMovie = initialMovie;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  int get currentPageIndex => _currentPageIndex;
  bool get isTrendingLoading => _isTrendingLoading;
  bool get isBestMoviesLoading => _isBestMoviesLoading;
  bool get isBestSeriesLoading => _isBestSeriesLoading;
  bool get isUpcomingMoviesLoading => _isUpcomingMoviesLoading;
  bool get isPopularMoviesLoading => _isPopularMoviesLoading;
  bool get isPopularSeriesLoading => _isPopularSeriesLoading;
  bool get isPeopleLoading => _isPeopleLoading;
  bool get isLatestSerieLoading => _isLatestSerieLoading;
  bool get isLatestMovieLoading => _isLatestMovieLoading;
  List<dynamic> get trendingItems => _trendingItems;
  List<Movie> get bestMovies => _bestMovies;
  List<TVSerie> get bestSeries => _bestSeries;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<TVSerie> get popularSeries => _popularSeries;
  List<Person> get people => _people;
  TVSerie get latestSerie => _latestSerie;
  Movie get latestMovie => _latestMovie;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  updateCurrentPageIndex(int newIndex) {
    _currentPageIndex = newIndex;
    notifyListeners();
  }

  updateTrendingLoader(bool newValue) {
    _isTrendingLoading = newValue;
    notifyListeners();
  }

  updateUpcomingLoader(bool newValue) {
    _isUpcomingMoviesLoading = newValue;
    notifyListeners();
  }

  updateLatestMovieLoader(bool newValue) {
    _isLatestMovieLoading = newValue;
    notifyListeners();
  }

  updateLatestSerieLoader(bool newValue) {
    _isLatestSerieLoading = newValue;
    notifyListeners();
  }

  updatePopularMoviesLoader(bool newValue) {
    _isPopularMoviesLoading = newValue;
    notifyListeners();
  }

  updatePopularSeriesLoader(bool newValue) {
    _isPopularSeriesLoading = newValue;
    notifyListeners();
  }

  updateBestMoviesLoader(bool newValue) {
    _isBestMoviesLoading = newValue;
    notifyListeners();
  }

  updateBestSeriesLoader(bool newValue) {
    _isBestSeriesLoading = newValue;
    notifyListeners();
  }

  updatePeopleLoader(bool newValue) {
    _isPeopleLoading = newValue;
    notifyListeners();
  }

  updateTrendingItems(List<dynamic> items) {
    _trendingItems = items;
    updateTrendingLoader(false);
    notifyListeners();
  }

  updateUpcomingMovies(List<Movie> items) {
    _upcomingMovies = items;
    updateUpcomingLoader(false);
    notifyListeners();
  }

  updateLatestMovie(Movie item) {
    _latestMovie = item;
    updateLatestMovieLoader(false);
    notifyListeners();
  }

  updateLatestSerie(TVSerie item) {
    _latestSerie = item;
    updateLatestSerieLoader(false);
    notifyListeners();
  }

  updatePopularMovies(List<Movie> items) {
    _popularMovies = items;
    updatePopularMoviesLoader(false);
    notifyListeners();
  }

  updatePopularSeries(List<TVSerie> items) {
    _popularSeries = items;
    updatePopularSeriesLoader(false);
    notifyListeners();
  }

  updateBestMovies(List<Movie> items) {
    _bestMovies = items;
    updateBestMoviesLoader(false);
    notifyListeners();
  }

  updateBestSeries(List<TVSerie> items) {
    _bestSeries = items;
    updateBestSeriesLoader(false);
    notifyListeners();
  }

  updatePeople(List<Person> items) {
    _people = items;
    updatePeopleLoader(false);
    notifyListeners();
  }

  updateScaffoldKey(GlobalKey<ScaffoldState> newScaffoldKey) {
    _scaffoldKey = newScaffoldKey;
  }
}
