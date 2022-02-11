class Movie {
  int id;
  String title;
  String originalTitle;
  String description;
  String releaseDate;
  num voteAverage;
  String backdropPath;
  String posterPath;
  String originalLanguage;
  List<int> genreIds;
  num popularity;
  num voteCount;
  String mediaType = "movie";

  Movie(
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
    this.mediaType
  );
}
