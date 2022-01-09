import 'package:movies/models/Provider.dart';

class TVSerie {
  int id;
  String name;
  String originalName;
  String description;
  String firstAirDate;
  num voteAverage;
  String backdropPath;
  String posterPath;
  String originalLanguage;
  List<int> genreIds;
  double popularity = 0;
  num voteCount;
  String mediaType = "tv";
  // List<Provider> providers;

  TVSerie(
    this.id, 
    this.name,
    this.originalName,
    this.description, 
    this.firstAirDate,
    this.voteAverage,
    this.backdropPath,
    this.posterPath,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.voteCount,
    this.mediaType
  );
}
