import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:movies/app_bar/app_bar.dart';
import 'package:movies/Colors/colors_theme.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/models/providers/provider_account.dart';
import 'package:movies/search_section/grid_view_search/grid_view_card/grid_view_card.dart';
import 'package:movies/Utilities/utilities.dart';
import 'package:movies/data_manager/data_manager.dart';
import 'package:movies/models/interfaces/serie_details.dart';
import 'package:movies/utilities/device_info.dart';
import 'package:movies/welcome_section/sign_in_section/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:movies/models/providers/provider_favs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailsSeriePage extends StatefulWidget {
  const DetailsSeriePage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  State<DetailsSeriePage> createState() => _DetailsSeriePageState();
}

class _DetailsSeriePageState extends State<DetailsSeriePage> {
  DataManager dataManager = DataManager();
  DeviceInfo deviceInfo = DeviceInfo();
  bool _isIPhoneNotch = false;
  dynamic get _item => widget.item;
  SerieDetails _serieDetails = initialSerieDetails;
  bool isFavourite = false;

  Future<void> _getDeviceInfo() async {
    _isIPhoneNotch = await deviceInfo.isIPhoneNotch();
  }

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      primary: ColorSelect.customMagenta,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final ButtonStyle _textButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white));

  void _getDetails() async {
    SerieDetails newSerieDetails = await dataManager.getSerieDetails(_item.id);
    if (mounted) {
      setState(() {
        _serieDetails = newSerieDetails;
      });
    }
    final Box<dynamic> _favBox = Hive.box<dynamic>("favBox");
    List<dynamic> newList = [];
    if (_favBox.get("favourites") != null) {
      newList = Utilities.fromHiveToDataGenericItem(_favBox.get("favourites"));
    }
    if (newList.indexWhere((element) => element.id == _item.id) >= 0) {
      setState(() {
        isFavourite = true;
      });
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _getDetails();
    });
    _getDeviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    // final Box<dynamic> _favBox = Hive.box<dynamic>("favBox");
    // _favBox.close();
    super.dispose();
  }

  void _openHomepage() async {
    if (!await launch(
        _serieDetails.homepage != "" ? _serieDetails.homepage : "")) {
      throw 'Could not launch ${_serieDetails.homepage}';
    }
  }

  void _launchTrailer() async {
    if (!await launch('$youtubePath${_serieDetails.trailer}')) {
      throw 'Could not launch $youtubePath${_serieDetails.trailer}';
    }
  }

  void _manageFavourites(ProviderAccount accountProvider) async {
    final Box<dynamic> _favBox = Hive.box<dynamic>("favBox");
    List<dynamic> tempList = [];
    if (accountProvider.isLogged) {
      if (_favBox.get("favourites") != null) {
        tempList = _favBox.get("favourites");
        if (tempList.any((element) => element.id == _item.id)) {
          tempList.removeWhere((element) => element.id == _item.id);
          setState(() {
            isFavourite = false;
          });
        } else {
          tempList = [...tempList, Utilities.fromDataToHiveSerie(_item)];
          setState(() {
            isFavourite = true;
          });
        }
      }
      await _favBox.put("favourites", tempList);
    } else {
      _firstLogin();
    }
  }

  void _navigateBack() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }

  Future<void> _firstLogin() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: ColorSelect.customBlue,
          titleTextStyle: const TextStyle(color: Colors.white),
          contentTextStyle: const TextStyle(color: Colors.white),
          title: const Text("Oh no it seems you aren't logged!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Sorry but you have to login to use this feature."),
                Text("Go back, sign in and then use favourite section."),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Sign in"),
              style: _buttonStyle,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              },
            ),
            TextButton(
              child: const Text('Close'),
              style: _textButton,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double textPadding = 75;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      if (_isIPhoneNotch) {
        textPadding = 70;
      } else {
        textPadding = 50;
      }
    } else {
      if (_isIPhoneNotch) {
        textPadding = 95;
      }
    }

    return Consumer<ProviderFavs>(builder: (context, favProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: const CustomAppBar(),
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: FloatingActionButton(
                  onPressed: _navigateBack,
                  backgroundColor: ColorSelect.customMagenta,
                  child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)))),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: textPadding)),
                    InkWell(
                        onTap: _launchTrailer,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                              height: MediaQuery.of(context).orientation == Orientation.landscape ? 330 : 240,
                              child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    FittedBox(
                                        child: _item.backdropPath != ""
                                            ? FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/placeholder_movie.png',
                                                image:
                                                    '$basePathImages${_item.backdropPath}')
                                            : const SizedBox(
                                                height: 240,
                                                child: FittedBox(
                                                    child: Image(
                                                  image: AssetImage(
                                                      "assets/images/placeholder_movie.png"),
                                                  fit: BoxFit.cover,
                                                ))),
                                        fit: BoxFit.cover),
                                    Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            gradient: RadialGradient(
                                                center: Alignment.center,
                                                radius: 1.0,
                                                colors: [
                                                  Colors.black54,
                                                  Colors.grey.withOpacity(0.0),
                                                ],
                                                stops: const [
                                                  0.0,
                                                  1.0,
                                                ]))),
                                    Container(
                                        alignment: Alignment.center,
                                        child: const Icon(
                                            Icons.play_arrow_outlined,
                                            size: 120,
                                            color: Colors.white70))
                                  ],
                                  fit: StackFit.expand)),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                          _serieDetails.name != "" ? _serieDetails.name : "",
                          style: const TextStyle(
                              fontSize: 28)),
                    ),
                    Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 30),
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: SizedBox(
                                      height: 170,
                                      child: _item.posterPath != ""
                                          ? FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/movie_poster_placeholder.jpeg',
                                              image:
                                                  '$basePathImages${_item.posterPath}')
                                          : const SizedBox(
                                              height: 170,
                                              child: FittedBox(
                                                  child: Image(
                                                image: AssetImage(
                                                    "assets/images/movie_poster_placeholder.jpeg"),
                                                fit: BoxFit.cover,
                                              ))),
                                    )),
                                Transform.translate(
                                    offset: const Offset(5, 10),
                                    child: ClipOval(
                                        child: CircularPercentIndicator(
                                      radius: 30,
                                      lineWidth: 7,
                                      backgroundColor: Colors.white,
                                      fillColor: Colors.grey.withOpacity(0.8),
                                      progressColor: ColorSelect.customBlue,
                                      percent: _serieDetails.voteAverage
                                              .ceilToDouble() /
                                          10,
                                      center: Text(
                                          _serieDetails.voteAverage.toString(),
                                          style: const TextStyle(
                                              color: ColorSelect.customBlue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700)),
                                    ))),
                              ])),
                      Expanded(
                          child: Column(children: [
                        Center(
                            child: Column(children: [
                          Text("Seasons: ${_serieDetails.seasons}",
                              style: const TextStyle(fontSize: 16)),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text("Episodes: ${_serieDetails.seasons}",
                              style: const TextStyle(fontSize: 16)),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: _openHomepage,
                                  style: buttonStyle,
                                  child: const Text("Open site"))),
                          Consumer<ProviderAccount>(
                              builder: (context, accountProvider, child) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        _manageFavourites(accountProvider),
                                    style: buttonStyle,
                                    child: isFavourite
                                        ? const Text("Remove from favourites")
                                        : const Text("Add to favourites")));
                          })
                        ])),
                          _serieDetails.watchProviders.isNotEmpty
                              ? GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7),
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount:
                                      _serieDetails.watchProviders.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.white,
                                            child: _serieDetails
                                                        .watchProviders[index]
                                                        .logoPath !=
                                                    ""
                                                ? FadeInImage.assetNetwork(
                                                    placeholder: '',
                                                    image:
                                                        '$basePathImages${_serieDetails.watchProviders[index].logoPath}',
                                                  fit: BoxFit.cover)
                                                : Container()));
                                  })
                              : Container()
                      ]))
                    ]),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                                color: ColorSelect.customBlue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: _serieDetails.description != ""
                                    ? Text(_serieDetails.description,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            height: 1.4,
                                            color: Colors.white))
                                    : const SizedBox(width: 0, height: 0)))),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    _serieDetails.gallery.isNotEmpty
                        ? const Text("Gallery",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))
                        : Container(),
                    _serieDetails.gallery.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: _serieDetails.gallery.length,
                            itemBuilder: (context, index) {
                              return (ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: SizedBox(
                                      height: 60,
                                      width: 110,
                                      child: _serieDetails.gallery[index] != ""
                                          ? FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/placeholder_movie.png',
                                              image:
                                                  '$basePathImages${_serieDetails.gallery[index]}',
                                                  fit: BoxFit.cover)
                                          : const SizedBox(
                                              height: 60,
                                              width: 110,
                                              child: FittedBox(
                                                  child: Image(
                                                image: AssetImage(
                                                    "assets/images/placeholder_movie.png"),
                                                fit: BoxFit.cover,
                                              ))))));
                            })
                        : Container(),
                    _serieDetails.similars.isNotEmpty
                        ? const Text("Suggested",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600))
                        : Container(),
                    _serieDetails.similars.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: _serieDetails.similars.length,
                            itemBuilder: (context, index) {
                              return GridViewCard(
                                  item: _serieDetails.similars[index]);
                            })
                        : Container(),
                  ]))));
    });
  }
}
