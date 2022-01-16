import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/providers/ProviderSearch.dart';
import 'package:provider/provider.dart';
import 'GridViewSearch/GridViewSearch.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  DataManager dataManager = DataManager();

  updateSearchText(ProviderSearch searchProvider) {
    searchProvider.updateSearchText(_searchController.text);
  }

  _discoverItems(ProviderSearch searchProvider) async {
    List<dynamic> newDiscoverItems =
        await dataManager.getDiscover(searchProvider.dropdownValue);
    searchProvider.updateSearchedItems(newDiscoverItems);
    searchProvider.updateIsSearch(false);
    searchProvider.updateLoader(false);
  }

  _searchItems(ProviderSearch searchProvider) async {
    searchProvider.updateLoader(true);
    List<dynamic> newSearchedItems =
        await dataManager.search(searchProvider.searchText);
    searchProvider.updateSearchedItems(newSearchedItems);
    searchProvider.updateIsSearch(true);
    searchProvider.updateLoader(false);
  }

  final ButtonStyle _searchButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  _filterClick(ProviderSearch searchProvider) {
    searchProvider.updateLoader(true);
    _searchController.text = "";
    searchProvider.updateSearchText("");
    searchProvider.updateLoader(false);
  }

  @override
  void initState() {
    ProviderSearch searchProvider =
        Provider.of<ProviderSearch>(context, listen: false);
    _discoverItems(searchProvider);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSearch>(builder: (context, searchProvider, child) {
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
                  _discoverItems(searchProvider);
                } else {
                  updateSearchText(searchProvider);
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
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 18),
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
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: searchProvider.dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                      color: ColorSelect.customBlue, fontSize: 18),
                  onChanged: (String? newValue) {
                    searchProvider.updateDropdownValue(newValue!);
                    _discoverItems(searchProvider);
                    _searchController.text = "";
                  },
                  items: <String>['Movie', 'TV serie']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))),
        Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
            child: Container(
                width: 380,
                height: 45,
                child: ElevatedButton(
                    style: _searchButtonStyle,
                    onPressed: () => _searchItems(searchProvider),
                    child: const Text("Search")))),
        searchProvider.isSearch
            ? const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 15),
                    child: Text("Results", style: TextStyle(fontSize: 20))))
            : Container(),
        const GridViewSearch()
      ]));
    });
  }
}
