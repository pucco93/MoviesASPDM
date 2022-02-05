import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/models/interfaces/movie_details.dart';
import 'package:movies/models/interfaces/person.dart';
import 'package:movies/models/interfaces/person_details.dart';
import 'package:movies/models/interfaces/serie_details.dart';
import 'package:movies/models/interfaces/tv_serie.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/Utilities/utilities.dart';

// Here goes methods to retrieve and manage data from APIs
class DataManager {
  final tmdb = TMDB(
    ApiKeys(v3Token, bearerV4Token),
  );

  getTrending() async {
    Map<dynamic, dynamic> tempMap = {};
    List<dynamic> newList = [];
    try {
      tempMap = await tmdb.v3.trending.getTrending();
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapGenericItem(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  search(String searchQuery) async {
    Map<dynamic, dynamic> tempMap = {};
    List<dynamic> newList = [];
    try {
      tempMap = await tmdb.v3.search.queryMulti(searchQuery);
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapGenericItem(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getDiscover(String type) async {
    Map<dynamic, dynamic> tempMap = {};
    List<dynamic> newList = [];
    try {
      if (type == "Movie") {
        tempMap = await tmdb.v3.discover.getMovies();
        if (!tempMap.containsKey("errors")) {
          newList = Utilities.mapMovies(tempMap["results"]);
          return newList;
        }
      } else {
        tempMap = await tmdb.v3.discover.getTvShows();
        if (!tempMap.containsKey("errors")) {
          newList = Utilities.mapTVSeries(tempMap["results"]);
          return newList;
        }
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getBestMovies() async {
    Map<dynamic, dynamic> tempMap = {};
    List<Movie> newList = [];
    try {
      tempMap = await tmdb.v3.movies.getTopRated(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapMovies(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getBestSeries() async {
    Map<dynamic, dynamic> tempMap = {};
    List<TVSerie> newList = [];
    try {
      tempMap = await tmdb.v3.tv.getTopRated(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapTVSeries(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getUpcomingMovies() async {
    Map<dynamic, dynamic> tempMap = {};
    List<Movie> newList = [];
    try {
      tempMap =
          await tmdb.v3.movies.getUpcoming(language: "it-IT", region: "IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapMovies(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getLatestMovie() async {
    Map<dynamic, dynamic> tempMap = {};
    Movie newMovie = initialMovie;
    try {
      tempMap = await tmdb.v3.movies.getLatest(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newMovie = Utilities.mapMovie(tempMap);
        return newMovie;
      }
      return newMovie;
    } catch (error) {
      return newMovie;
    }
  }

  getLatestSerie() async {
    Map<dynamic, dynamic> tempMap = {};
    TVSerie newSerie = initialSerie;
    try {
      tempMap = await tmdb.v3.tv.getLatest(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newSerie = Utilities.mapTVSerie(tempMap);
        return newSerie;
      }
      return newSerie;
    } catch (error) {
      return newSerie;
    }
  }

  getPopularMovies() async {
    Map<dynamic, dynamic> tempMap = {};
    List<Movie> newList = [];
    try {
      tempMap =
          await tmdb.v3.movies.getPouplar(language: "it-IT", region: "IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapMovies(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getPopularTVSeries() async {
    Map<dynamic, dynamic> tempMap = {};
    List<TVSerie> newList = [];
    try {
      tempMap = await tmdb.v3.tv.getPouplar(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapTVSeries(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getPopularPeople() async {
    Map<dynamic, dynamic> tempMap = {};
    List<Person> newList = [];
    try {
      tempMap = await tmdb.v3.people.getPopular(language: "it-IT");
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapPeople(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  getMovieDetails(int itemId) async {
    Map<dynamic, dynamic> tempMap = {};
    MovieDetails movieDetails = initialMovieDetails;
    try {
      tempMap = await tmdb.v3.movies.getDetails(itemId,
          language: "it-IT",
          appendToResponse: "videos,images,watch/providers,similar");
      if (!tempMap.containsKey("errors") &&
          !tempMap[movieDetailsTrailer].containsKey("errors") &&
          !tempMap[movieDetailsSimilars].containsKey("errors") &&
          !tempMap[movieDetailsImages].containsKey("errors") &&
          !tempMap[movieDetailsWatchProviders].containsKey("errors")) {
        movieDetails = Utilities.mapMovieDetails(tempMap);
        return movieDetails;
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  getSerieDetails(int id) async {
    Map<dynamic, dynamic> tempMap = {};
    SerieDetails serieDetails = initialSerieDetails;
    try {
      tempMap = await tmdb.v3.tv.getDetails(id,
          appendToResponse: "videos,images,watch/providers,similar");
      if (!tempMap.containsKey("errors") &&
          !tempMap[movieDetailsTrailer].containsKey("errors") &&
          !tempMap[movieDetailsSimilars].containsKey("errors") &&
          !tempMap[movieDetailsImages].containsKey("errors") &&
          !tempMap[movieDetailsWatchProviders].containsKey("errors")) {
        serieDetails = Utilities.mapSerieDetails(tempMap);
        return serieDetails;
      }
    } catch (error) {
      return null;
    }
  }

  getPersonDetails(int id) async {
    Map<dynamic, dynamic> tempMap = {};
    PersonDetails personDetails = initialPersonDetails;
    try {
      tempMap = await tmdb.v3.people.getDetails(id, appendToResponse: "images");
      if (!tempMap.containsKey("errors") &&
          !tempMap[movieDetailsImages].containsKey("errors")) {
        personDetails = Utilities.mapPersonDetails(tempMap);
        return personDetails;
      }
    } catch (error) {
      return null;
    }
  }

  getFavs() async {
    Map<dynamic, dynamic> tempMap = {};
    List<dynamic> newList = [];
    try {
      tempMap = {};
      if (!tempMap.containsKey("errors")) {
        newList = Utilities.mapGenericItem(tempMap["results"]);
        return newList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  addFav() {}

  deleteFav() {}
}
