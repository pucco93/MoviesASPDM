import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/FavouritesSection/GridItemShimmer.dart';
import 'package:movies/FavouritesSection/GridViewCard/GridViewCard.dart';
import 'package:movies/Utilities/Utilities.dart';
import 'package:movies/WelcomeSection/SignUpSection/SignUpPage.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/providers/ProviderAccount.dart';
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
    final Box<dynamic> _favBox = Hive.box<dynamic>("favBox");
    List<dynamic> newList = [];
    favProvider.updateLoading(true);
    if (_favBox.get("favourites") ?? true) {
      newList = Utilities.fromHiveToDataGenericItem(_favBox.get("favourites"));
    }
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
    return Consumer<ProviderAccount>(
        builder: (context, accountProvider, child) {
      return Consumer<ProviderFavs>(builder: (context, favsProvider, child) {
        return accountProvider.isLogged
            ? SingleChildScrollView(
                child: Column(children: [
                const Padding(padding: EdgeInsets.only(top: 95)),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Favourites",
                            style: TextStyle(fontSize: 20)))),
                favsProvider.isFavLoading
                    ? const GridViewShimmer()
                    : GridView.builder(
                        padding: const EdgeInsets.only(top: 15, bottom: 80),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: favsProvider.favList.length,
                        itemBuilder: (context, index) {
                          return favsProvider.favList.isNotEmpty
                              ? GridViewCard(item: favsProvider.favList[index])
                              : const NoElementsFound();
                        })
              ]))
            : NotLogged();
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
            child:
                Consumer<ProviderFavs>(builder: (context, favProvider, child) {
              return const Text("No favourite elements.");
            })));
  }
}

class NotLogged extends StatelessWidget {
  NotLogged({Key? key}) : super(key: key);

  final ButtonStyle _loginButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  @override
  Widget build(BuildContext context) {
    void _openSignUp() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignUpPage()));
    }

    return Consumer<ProviderAccount>(
        builder: (context, accountProvider, child) {
      return Column(children: [
        const Padding(padding: EdgeInsets.only(top: 100)),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
                child: Text(
              "Log in to use the favourites section",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ))),
        ElevatedButton(
          child: const Text("Sign in", style: TextStyle(fontSize: 22)),
          style: _loginButton,
          onPressed: _openSignUp,
        )
      ]);
    });
  }
}
