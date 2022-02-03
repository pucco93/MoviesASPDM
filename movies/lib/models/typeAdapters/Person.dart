import 'dart:core';

import 'package:hive/hive.dart';

part 'Person.g.dart';

@HiveType(typeId: 34)
class PersonHive {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String department;
  @HiveField(3)
  List<dynamic> knownFor;
  @HiveField(4)
  num popularity;
  @HiveField(5)
  String posterPath;
  @HiveField(6)
  String mediaType = "person";

  PersonHive(this.id, this.name, this.department, this.knownFor, this.popularity,
      this.posterPath);
}
