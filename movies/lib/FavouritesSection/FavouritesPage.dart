import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/FavouritesSection/GridItemShimmer.dart';
import 'package:movies/FavouritesSection/GridViewCard/GridViewCard.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/providers/ProviderFavs.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  DataManager dataManager = DataManager();

  void _getFavs(ProviderFavs favProvider) async {
    favProvider.updateLoading(true);
    List<dynamic> newList = await dataManager.getFavs();
    favProvider.updateFavItems(newList);
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ProviderFavs favProvider =
          Provider.of<ProviderFavs>(context, listen: false);
      _getFavs(favProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFavs>(builder: (context, favsProvider, child) {
      return SingleChildScrollView(
          child: Column(children: [
        const Padding(padding: EdgeInsets.only(top: 95)),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Favourites", style: TextStyle(fontSize: 20)))),
        const Padding(padding: EdgeInsets.only(top: 40)),
        favsProvider.isFavLoading
            ? const GridViewShimmer()
            : GridView.builder(
                padding: const EdgeInsets.only(top: 15, bottom: 80),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: favsProvider.favList.length,
                itemBuilder: (context, index) {
                  return favsProvider.favList.isNotEmpty
                      ? GridViewCard(item: favsProvider.favList[index])
                      : const NoElementsFound();
                })
      ]));
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
            child:
                Consumer<ProviderFavs>(builder: (context, favProvider, child) {
              return const Text("No favourite elements.");
            })));
  }
}
