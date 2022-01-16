import 'package:flutter/material.dart';

class ProviderSearch extends ChangeNotifier {
  bool _isLoading = true;
  bool _isSearch = false;
  List<dynamic> _searchedItems = []; // Movie, TVSerie
  String _dropdownValue = "Movie";
  String _searchText = "";

  // Getter
  bool get isLoading => _isLoading;
  bool get isSearch => _isSearch;
  String get dropdownValue => _dropdownValue;
  String get searchText => _searchText;
  List<dynamic> get searchedItems => _searchedItems;

  updateLoader(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  updateSearchedItems(List<dynamic> newSearchedItems) {
    _searchedItems = newSearchedItems;
    notifyListeners();
  }

  updateDropdownValue(String newValue) {
    _dropdownValue = newValue;
    notifyListeners();
  }

  updateSearchText(String newValue) {
    _searchText = newValue;
    notifyListeners();
  }

  updateIsSearch(bool newValue) {
    _isSearch = newValue;
    notifyListeners();
  }
}
