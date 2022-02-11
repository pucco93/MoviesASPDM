import 'package:movies/models/interfaces/Provider.dart';
import 'package:movies/models/interfaces/tv_serie.dart';

class SerieDetails extends TVSerie {
  final int seasons;
  final int episodes;
  final String homepage;
  final String trailer;
  final List<String> gallery;
  final List<Provider> watchProviders;
  final List<dynamic> similars;

  SerieDetails(
      this.seasons,
      this.episodes,
      this.homepage,
      this.trailer,
      this.gallery,
      this.watchProviders,
      this.similars,
      int id,
      String name,
      String originalName,
      String description,
      String firstAirDate,
      num voteAverage,
      String backdropPath,
      String posterPath,
      String originalLanguage,
      List<int> genreIds,
      double popularity,
      num voteCount,
      String mediaType)
      : super(
            id,
            name,
            originalName,
            description,
            firstAirDate,
            voteAverage,
            backdropPath,
            posterPath,
            originalLanguage,
            genreIds,
            popularity,
            voteCount,
            mediaType = "tv");
}
