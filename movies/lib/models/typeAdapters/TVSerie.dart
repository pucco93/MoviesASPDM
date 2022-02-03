import 'dart:core';

import 'package:hive/hive.dart';

part 'TVSerie.g.dart';

@HiveType(typeId: 35)
class TVSerieHive {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String originalName;
  @HiveField(3)
  String description;
  @HiveField(4)
  String firstAirDate;
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
  double popularity = 0;
  @HiveField(11)
  num voteCount;
  @HiveField(12)
  String mediaType = "tv";

  TVSerieHive(
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
