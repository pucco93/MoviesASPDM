import 'dart:core';

import 'package:hive/hive.dart';

part 'LoggedUser.g.dart';

@HiveType(typeId: 36)
class LoggedUser {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String imageUrl;
  @HiveField(5)
  bool isLogged;

  LoggedUser(
    this.id, 
    this.name, 
    this.email, 
    this.password, 
    this.imageUrl,
    this.isLogged
  );
}
