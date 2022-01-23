import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/Person.dart';

class PersonDetails extends Person {
  final String homepage;
  final List<String> gallery;
  final String birthday;
  final String deathday;
  final String alsoKnownAs;
  final String biography;
  final String placeOfBirth;

  PersonDetails(
    this.homepage,
    this.gallery,
    this.birthday,
    this.deathday,
    this.alsoKnownAs,
    this.biography,
    this.placeOfBirth,
      int id,
      String name,
      String department,
      List<dynamic> knownFor,
      num popularity,
      String posterPath,
      String mediaType)
      : super(
            id,
            name,
            department,
            knownFor,
            popularity,
            posterPath);
}