import 'package:flutter/material.dart';

class ProviderFavs extends ChangeNotifier {
  bool _isFavLoading = false;
  List<dynamic> _favList = [];

  bool get isFavLoading => _isFavLoading;
  List<dynamic> get favList => _favList;

  void updateLoading(bool newValue) {
    _isFavLoading = newValue;
    notifyListeners();
  }

  void updateFavItems(List<dynamic> newList) {
    _favList = newList;
    updateLoading(false);
    notifyListeners();
  }
}
