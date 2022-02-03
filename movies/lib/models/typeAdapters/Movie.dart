import 'dart:core';

import 'package:hive/hive.dart';

part 'Movie.g.dart';

@HiveType(typeId: 33)
class MovieHive {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String originalTitle;
  @HiveField(3)
  String description;
  @HiveField(4)
  String releaseDate;
  @HiveField(5)
  num voteAverage;
  @HiveField(6)
  String backdropPath;
  @HiveField(7)
  String posterPath;
  @HiveField(8)
  String originalLanguage;
  @HiveField(9)
  List<int> genreIds;
  @HiveField(10)
  num popularity;
  @HiveField(11)
  num voteCount;
  @HiveField(12)
  String mediaType = "movie";

  MovieHive(
      this.id,
      this.title,
      this.originalTitle,
      this.description,
      this.releaseDate,
      this.voteAverage,
      this.backdropPath,
      this.posterPath,
      this.originalLanguage,
      this.genreIds,
      this.popularity,
      this.voteCount,
      this.mediaType);
}
