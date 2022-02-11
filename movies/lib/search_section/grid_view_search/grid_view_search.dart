import 'package:flutter/material.dart';
import 'package:movies/models/providers/provider_search.dart';
import 'package:movies/utilities/device_info.dart';
import 'package:provider/provider.dart';
import 'grid_item_shimmer.dart';
import 'grid_view_card/grid_view_card.dart';

class GridViewSearch extends StatefulWidget {
  const GridViewSearch({Key? key}) : super(key: key);

  @override
  State<GridViewSearch> createState() => _GridViewSearchState();
}

class _GridViewSearchState extends State<GridViewSearch> {
  DeviceInfo deviceInfo = DeviceInfo();
  bool _isIPhoneNotch = false;

  Future<void> _getDeviceInfo() async {
    _isIPhoneNotch = await deviceInfo.isIPhoneNotch();
  }

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSearch>(builder: (context, searchProvider, child) {
      return searchProvider.isLoading
          ? const GridViewShimmer()
          : GridView.builder(
              padding:
                  EdgeInsets.only(top: 15, bottom: _isIPhoneNotch ? 110 : 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: searchProvider.searchedItems.length,
              itemBuilder: (context, index) {
                return searchProvider.searchedItems.isNotEmpty
                    ? GridViewCard(item: searchProvider.searchedItems[index])
                    : const NoElementsFound();
              });
    });
  }
}

class NoElementsFound extends StatelessWidget {
  const NoElementsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Consumer<ProviderSearch>(
                builder: (context, searchProvider, child) {
              return Text(
                  "No element found searching for ${searchProvider.searchText}");
            })));
  }
}
