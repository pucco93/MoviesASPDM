import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'GridViewSearch/GridViewSearch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _searchedItems = []; // Movie, TVSerie
  final _searchController = TextEditingController();
  String _dropdownValue = "Movie";
  bool _isLoading = false;
  DataManager dataManager = DataManager();

  final ButtonStyle _searchButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  updateLoader() {
    if (mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  _searchItems() async {
    List<dynamic> newSearchedItems =
        await dataManager.search(_searchController.text);

    if (mounted) {
      setState(() {
        _searchedItems = newSearchedItems;
      });
    }
  }

  _discoverItems() async {
    updateLoader();
    List<dynamic> newDiscoverItems =
        await dataManager.getDiscover(_dropdownValue);
    if (mounted) {
      setState(() {
        _searchedItems = newDiscoverItems;
      });
    }
    updateLoader();
  }

  _filterClick() {
    _searchController.text = "";
  }

  _openItem(dynamic item) {}

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _discoverItems();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 95)),
      const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Discover", style: TextStyle(fontSize: 20)))),
      Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: TextField(
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
            keyboardType: TextInputType.text,
            controller: _searchController,
            onChanged: (text) {
              if (text == "") {
                _discoverItems();
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: ColorSelect.customBlue, width: 3.0)),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white),
          )),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  width: 360,
                  child: DropdownButton<String>(
                    value: _dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                        color: ColorSelect.customBlue, fontSize: 18),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Movie', 'TV serie']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Container(
              width: 380,
              child: ElevatedButton(
                  style: _searchButtonStyle,
                  onPressed: _searchItems,
                  child: const Text("Search")))),
      GridViewSearch(
          searchItems: _searchItems,
          openItem: _openItem,
          searchedItems: _searchedItems,
          isLoading: _isLoading)
    ]));
  }
}
