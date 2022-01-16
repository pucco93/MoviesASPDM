import 'package:flutter/material.dart';
import 'package:movies/models/interfaces/User.dart';

class ProviderAccount extends ChangeNotifier {
  bool notDeleted = false;
  String _name = "";
  String _mail = "";
  String _imageUrl = "";
  String _linkedBySocial = ""; // Nome social
  bool _isLogged = false;

  String get name => _name;
  String get mail => _mail;
  String get imageUrl => _imageUrl;
  String get linkedBySocial => _linkedBySocial;
  bool get isLogged => _isLogged;

  updateUser(User user) {
    _name = user.name;
    _mail = user.mail;
    _imageUrl = user.imageUrl;
  }
}
