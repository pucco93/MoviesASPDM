import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/models/interfaces/Person.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Utilities {
  static Movie mapMovie(dynamic item) {
    List<int> genreIDs = [];
    item[movieGenreIDs]?.forEach((element) => {genreIDs.add(element as int)});
    Movie movie = Movie(
        item[movieID],
        item[movieTitle] ?? "",
        item[movieOgTitle] ?? "",
        item[movieOverview] ?? "",
        item[movieReleaseDate] ?? "",
        item[movieVoteAvg] ?? 0,
        item[moviebdPath] ?? "",
        item[moviePosterPath] ?? "",
        item[movieOgLanguage] ?? "",
        genreIDs,
        item[moviePopularity] ?? 0,
        item[movieVoteCount] ?? 0,
        item[mediaType] ?? "movie");

    return movie;
  }

  static List<Movie> mapMovies(dynamic unmapped) {
    List<Movie> movies = [];
    if(unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        movies.add(mapMovie(item));
      });
    }
    return movies;
  }

  static TVSerie mapTVSerie(dynamic item) {
    List<int> genreIDs = [];
    item[movieGenreIDs]?.forEach((element) => {genreIDs.add(element as int)});
    TVSerie serie = TVSerie(
        item[serieID],
        item[serieName] ?? "",
        item[serieOgName] ?? "",
        item[serieOverview] ?? "",
        item[serieFirstAirDate] ?? "",
        item[serieVoteAvg] ?? 0,
        item[seriebdPath] ?? "",
        item[seriePosterPath] ?? "",
        item[serieOgLanguage] ?? "",
        genreIDs,
        item[seriePopularity] ?? 0,
        item[serieVoteCount] ?? 0,
        item[mediaType] ?? "tv");
    return serie;
  }

  static List<TVSerie> mapTVSeries(dynamic unmapped) {
    List<TVSerie> series = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        series.add(mapTVSerie(item));
      });
    }
    return series;
  }

  static List<dynamic> mapGenericItem(dynamic unmapped) {
    List<dynamic> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        if (item[mediaType] == "movie") {
          Movie newMovie = mapMovie(item);
          mapped.add(newMovie);
        } else if (item[mediaType] == "tv") {
          TVSerie newTVSerie = mapTVSerie(item);
          mapped.add(newTVSerie);
        } else if (item[mediaType] == "person") {
          Person newPerson = mapPerson(item);
          mapped.add(newPerson);
        }
      });
    }
    return mapped;
  }

  static Person mapPerson(dynamic item) {
    List<dynamic> genericItems = mapGenericItem(item[personKnownFor]);
    Person person = Person(
        item[personId],
        item[personName] ?? "",
        item[personDepartment] ?? "",
        genericItems,
        item[personPopularity] ?? 0,
        item[personProfilePath] ?? "");
    return person;
  }

  static List<Person> mapPeople(dynamic unmapped) {
    List<Person> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        mapped.add(mapPerson(item));
      });
    }
    return mapped;
  }
}
