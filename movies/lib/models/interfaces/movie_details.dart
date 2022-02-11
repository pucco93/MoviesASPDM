import 'package:movies/models/interfaces/movie.dart';
import 'package:movies/models/interfaces/Provider.dart';

class MovieDetails extends Movie {
  final int runtime;
  final String homepage;
  final String trailer;
  final List<String> gallery;
  final List<Provider> watchProviders;
  final List<dynamic> similars;

  MovieDetails(
      this.runtime,
      this.homepage,
      this.trailer,
      this.gallery,
      this.watchProviders,
      this.similars,
      int id,
      String title,
      String originalTitle,
      String description,
      String releaseDate,
      num voteAverage,
      String backdropPath,
      String posterPath,
      String originalLanguage,
      List<int> genreIds,
      num popularity,
      num voteCount,
      String mediaType)
      : super(
            id,
            title,
            originalTitle,
            description,
            releaseDate,
            voteAverage,
            backdropPath,
            posterPath,
            originalLanguage,
            genreIds,
            popularity,
            voteCount,
            mediaType = "movie");
}
