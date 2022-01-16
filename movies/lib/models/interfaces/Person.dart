import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/TVSerie.dart';

class Person {
  int id;
  String name;
  String department;
  List<dynamic> knownFor;
  num popularity;
  String posterPath;
  String mediaType = "person";

  Person(this.id, this.name, this.department, this.knownFor, this.popularity,
      this.posterPath);
}
