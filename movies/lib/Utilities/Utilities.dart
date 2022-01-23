import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/MovieDetails.dart';
import 'package:movies/models/interfaces/PersonDetails.dart';
import 'package:movies/models/interfaces/Provider.dart';
import 'package:movies/models/interfaces/SerieDetails.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/models/interfaces/Person.dart';

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
    if (unmapped != null && unmapped.isNotEmpty) {
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

  static MovieDetails mapMovieDetails(dynamic unmapped) {
    List<int> genreIDs = [];
    List<String> gallery = [];
    List<Provider> watchProviders = [];
    List<dynamic> similars = [];
    String trailer = "";
    if (unmapped[movieGenres] != null) {
      unmapped[movieGenres]
          ?.forEach((element) => {genreIDs.add(element["id"] as int)});
    }
    if (unmapped[movieDetailsImages] != null &&
        unmapped[movieDetailsImages][movieDetailsBackdrops] != null) {
      unmapped[movieDetailsImages][movieDetailsBackdrops]
          ?.forEach((element) => {gallery.add(element[movieDetailsFilePath])});
    }
    if (unmapped[movieDetailsSimilars] != null &&
        unmapped[movieDetailsSimilars]["results"] != null) {
      dynamic tempList = [
        ...Utilities.mapMovies(unmapped[movieDetailsSimilars]?["results"])
      ];
      similars = tempList?.length > 10 ? tempList.sublist(0, 10) : tempList;
    }
    if (unmapped[movieDetailsWatchProviders] != null &&
        unmapped[movieDetailsWatchProviders]["results"] != null &&
        unmapped[movieDetailsWatchProviders]["results"][itLanguage] != null &&
        unmapped[movieDetailsWatchProviders]["results"][itLanguage]
                [streaming] !=
            null) {
      unmapped[movieDetailsWatchProviders]["results"][itLanguage][streaming]
          ?.forEach((element) => {
                watchProviders
                    .add(Provider(element[providerName], element[providerLogo]))
              });
    }
    if (unmapped[movieDetailsTrailer] != null &&
        unmapped[movieDetailsTrailer]["results"] != null &&
        unmapped[movieDetailsTrailer]["results"].isNotEmpty &&
        unmapped[movieDetailsTrailer]["results"][0]["id"] != null) {
      trailer = unmapped[movieDetailsTrailer]["results"][0]["id"];
    }
    MovieDetails movieDetails = MovieDetails(
        unmapped[movieDetailsRuntime] ?? 0,
        unmapped[movieDetailsHomepage] ?? "",
        trailer,
        gallery,
        watchProviders,
        similars,
        unmapped[movieID],
        unmapped[movieTitle] ?? "",
        unmapped[movieOgTitle] ?? "",
        unmapped[movieOverview] ?? "",
        unmapped[movieReleaseDate] ?? "",
        unmapped[movieVoteAvg] ?? 0,
        unmapped[moviebdPath] ?? "",
        unmapped[moviePosterPath] ?? "",
        unmapped[movieOgLanguage] ?? "",
        genreIDs,
        unmapped[moviePopularity] ?? 0,
        unmapped[movieVoteCount] ?? 0,
        unmapped[mediaType] ?? "movie");

    return movieDetails;
  }

  static SerieDetails mapSerieDetails(dynamic unmapped) {
    List<int> genreIDs = [];
    List<String> gallery = [];
    List<Provider> watchProviders = [];
    List<dynamic> similars = [];
    String trailer = "";
    if (unmapped[movieGenres] != null) {
      unmapped[movieGenres]
          ?.forEach((element) => {genreIDs.add(element["id"] as int)});
    }
    if (unmapped[movieDetailsImages] != null &&
        unmapped[movieDetailsImages][movieDetailsBackdrops] != null) {
      unmapped[movieDetailsImages][movieDetailsBackdrops]
          ?.forEach((element) => {gallery.add(element[movieDetailsFilePath])});
    }
    if (unmapped[movieDetailsSimilars] != null &&
        unmapped[movieDetailsSimilars]["results"] != null) {
      similars = [
        ...Utilities.mapTVSeries(unmapped[movieDetailsSimilars]["results"])
      ].sublist(0, 10);
    }
    if (unmapped[movieDetailsWatchProviders] != null &&
        unmapped[movieDetailsWatchProviders]["results"] != null &&
        unmapped[movieDetailsWatchProviders]["results"][itLanguage] != null &&
        unmapped[movieDetailsWatchProviders]["results"][itLanguage]
                [streaming] !=
            null) {
      unmapped[movieDetailsWatchProviders]["results"][itLanguage][streaming]
          ?.forEach((element) => {
                watchProviders
                    .add(Provider(element[providerName], element[providerLogo]))
              });
    }
    if (unmapped[movieDetailsTrailer] != null &&
        unmapped[movieDetailsTrailer]["results"] != null &&
        unmapped[movieDetailsTrailer]["results"][0] != null &&
        unmapped[movieDetailsTrailer]["results"][0]["id"] != null) {
      trailer = unmapped[movieDetailsTrailer]["results"][0]["id"];
    }

    SerieDetails serieDetails = SerieDetails(
        unmapped[serieSeasons] ?? 0,
        unmapped[serieEpisodes] ?? 0,
        unmapped[movieDetailsHomepage] ?? "",
        trailer,
        gallery,
        watchProviders,
        similars,
        unmapped[serieID],
        unmapped[serieName] ?? "",
        unmapped[serieOgName] ?? "",
        unmapped[serieOverview] ?? "",
        unmapped[serieFirstAirDate] ?? "",
        unmapped[serieVoteAvg] ?? 0,
        unmapped[seriebdPath] ?? "",
        unmapped[seriePosterPath] ?? "",
        unmapped[serieOgLanguage] ?? "",
        genreIDs,
        unmapped[seriePopularity] ?? 0,
        unmapped[serieVoteCount] ?? 0,
        unmapped[mediaType] ?? "tv");

    return serieDetails;
  }

  static PersonDetails mapPersonDetails(dynamic unmapped) {
    List<String> gallery = [];
    if (unmapped[movieDetailsImages] != null &&
        unmapped[movieDetailsImages][movieDetailsBackdrops] != null) {
      unmapped[movieDetailsImages][movieDetailsBackdrops]
          ?.forEach((element) => {gallery.add(element[movieDetailsFilePath])});
    }
    PersonDetails personDetails = PersonDetails(
        unmapped[movieDetailsHomepage] ?? "",
        gallery,
        unmapped[personBirthday] ?? "",
        unmapped[personDeathday] ?? "",
        unmapped[personAlsoKnownAs] ?? "",
        unmapped[personBiography] ?? "",
        unmapped[personPlaceOfBirth] ?? "",
        unmapped[personId] ?? "",
        unmapped[personName] ?? "",
        unmapped[personDepartment] ?? "",
        [...Utilities.mapMovies(unmapped[personKnownFor])],
        unmapped[personPopularity] ?? "",
        unmapped[personProfilePath] ?? "",
        unmapped[mediaType] ?? "person");

    return personDetails;
  }
}
