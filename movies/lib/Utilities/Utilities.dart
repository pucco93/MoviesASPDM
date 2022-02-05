import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/models/interfaces/movie_details.dart';
import 'package:movies/models/interfaces/person_details.dart';
import 'package:movies/models/interfaces/Provider.dart';
import 'package:movies/models/interfaces/serie_details.dart';
import 'package:movies/models/interfaces/tv_serie.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/models/interfaces/person.dart';
import 'package:movies/models/type_adapters/logged_user.dart';
import 'package:movies/models/type_adapters/movie_hive.dart';
import 'package:movies/models/type_adapters/person_hive.dart';
import 'package:movies/models/type_adapters/tv_serie.dart';

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
    if (gallery.length > 10) {
      dynamic tempList = gallery.sublist(0, 10);
      gallery = tempList;
    }
    if (unmapped[movieDetailsSimilars] != null &&
        unmapped[movieDetailsSimilars]["results"] != null) {
      dynamic tempList = [
        ...Utilities.mapTVSeries(unmapped[movieDetailsSimilars]["results"])
      ];
      similars = tempList.length > 10 ? tempList.sublist(0, 10) : tempList;
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
        unmapped[movieDetailsImages][personProfiles] != null) {
      unmapped[movieDetailsImages][personProfiles]
          ?.forEach((element) => {gallery.add(element[movieDetailsFilePath])});
    }
    if (gallery.length > 10) {
      dynamic tempList = gallery.sublist(0, 10);
      gallery = tempList;
    }
    PersonDetails personDetails = PersonDetails(
        unmapped[movieDetailsHomepage] ?? "",
        gallery,
        unmapped[personBirthday] ?? "",
        unmapped[personDeathday] ?? "",
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

  static List<MovieHive> fromDataToHiveMovies(dynamic unmapped) {
    List<MovieHive> movies = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        movies.add(fromDataToHiveMovie(item));
      });
    }
    return movies;
  }

  static MovieHive fromDataToHiveMovie(Movie movie) {
    MovieHive newMovie = MovieHive(
        movie.id,
        movie.title,
        movie.originalTitle,
        movie.description,
        movie.releaseDate,
        movie.voteAverage,
        movie.backdropPath,
        movie.posterPath,
        movie.originalLanguage,
        movie.genreIds,
        movie.popularity,
        movie.voteCount,
        "movie");

    return newMovie;
  }

  static TVSerieHive fromDataToHiveSerie(TVSerie item) {
    TVSerieHive serie = TVSerieHive(
        item.id,
        item.name,
        item.originalName,
        item.description,
        item.firstAirDate,
        item.voteAverage,
        item.backdropPath,
        item.posterPath,
        item.originalLanguage,
        item.genreIds,
        item.popularity,
        item.voteCount,
        "tv");
    return serie;
  }

  static List<TVSerieHive> fromDataToHiveSeries(dynamic unmapped) {
    List<TVSerieHive> series = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        series.add(fromDataToHiveSerie(item));
      });
    }
    return series;
  }

  static PersonHive fromDataToHivePerson(Person item) {
    List<dynamic> genericItems = fromDataToHiveGenericItem(item.knownFor);
    PersonHive person = PersonHive(item.id, item.name, item.department,
        genericItems, item.popularity, item.posterPath);
    return person;
  }

  static List<PersonHive> fromDataToHivePeople(dynamic unmapped) {
    List<PersonHive> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        mapped.add(fromDataToHivePerson(item));
      });
    }
    return mapped;
  }

  static List<dynamic> fromDataToHiveGenericItem(dynamic unmapped) {
    List<dynamic> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        if (item.mediaType == "movie") {
          MovieHive newMovie = fromDataToHiveMovie(item);
          mapped.add(newMovie);
        } else if (item.mediaType == "tv") {
          TVSerieHive newTVSerie = fromDataToHiveSerie(item);
          mapped.add(newTVSerie);
        } else if (item.mediaType == "person") {
          PersonHive newPerson = fromDataToHivePerson(item);
          mapped.add(newPerson);
        }
      });
    }
    return mapped;
  }

  static List<Movie> fromHiveToDataMovies(dynamic unmapped) {
    List<Movie> movies = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        movies.add(fromHiveToDataMovie(item));
      });
    }
    return movies;
  }

  static Movie fromHiveToDataMovie(MovieHive movie) {
    Movie newMovie = Movie(
        movie.id,
        movie.title,
        movie.originalTitle,
        movie.description,
        movie.releaseDate,
        movie.voteAverage,
        movie.backdropPath,
        movie.posterPath,
        movie.originalLanguage,
        movie.genreIds,
        movie.popularity,
        movie.voteCount,
        "movie");

    return newMovie;
  }

  static TVSerie fromHiveToDataSerie(TVSerieHive item) {
    TVSerie serie = TVSerie(
        item.id,
        item.name,
        item.originalName,
        item.description,
        item.firstAirDate,
        item.voteAverage,
        item.backdropPath,
        item.posterPath,
        item.originalLanguage,
        item.genreIds,
        item.popularity,
        item.voteCount,
        "tv");
    return serie;
  }

  static List<TVSerie> fromHiveToDataSeries(dynamic unmapped) {
    List<TVSerie> series = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        series.add(fromHiveToDataSerie(item));
      });
    }
    return series;
  }

  static Person fromHiveToDataPerson(PersonHive item) {
    List<dynamic> genericItems = fromHiveToDataGenericItem(item.knownFor);
    Person person = Person(item.id, item.name, item.department, genericItems,
        item.popularity, item.posterPath);
    return person;
  }

  static List<Person> fromHiveToDataPeople(dynamic unmapped) {
    List<Person> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        mapped.add(fromHiveToDataPerson(item));
      });
    }
    return mapped;
  }

  static List<dynamic> fromHiveToDataGenericItem(dynamic unmapped) {
    List<dynamic> mapped = [];
    if (unmapped != null && unmapped.isNotEmpty) {
      unmapped.forEach((item) {
        if (item.mediaType == "movie") {
          Movie newMovie = fromHiveToDataMovie(item);
          mapped.add(newMovie);
        } else if (item.mediaType == "tv") {
          TVSerie newTVSerie = fromHiveToDataSerie(item);
          mapped.add(newTVSerie);
        } else if (item.mediaType == "person") {
          Person newPerson = fromHiveToDataPerson(item);
          mapped.add(newPerson);
        }
      });
    }
    return mapped;
  }

  static LoggedUser mapLoggedUser(dynamic box) {
    LoggedUser mapped = initialLoggedUser;
    mapped = LoggedUser(
        box.id, box.name, box.email, box.password, box.imageUrl, box.isLogged);
    return mapped;
  }
}
