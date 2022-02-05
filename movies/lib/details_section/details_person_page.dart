import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies/app_bar/app_bar.dart';
import 'package:movies/Colors/colors_theme.dart';
import 'package:movies/Constants/constants.dart';
import 'package:movies/search_section/grid_view_search/grid_view_card/grid_view_card.dart';
import 'package:movies/data_manager/data_manager.dart';
import 'package:movies/models/interfaces/person_details.dart';
import 'package:movies/models/providers/provider_favs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPersonPage extends StatefulWidget {
  const DetailsPersonPage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  State<DetailsPersonPage> createState() => _DetailsPersonPageState();
}

class _DetailsPersonPageState extends State<DetailsPersonPage> {
  DataManager dataManager = DataManager();
  dynamic get _item => widget.item;
  PersonDetails _personDetails = initialPersonDetails;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  void _getDetails() async {
    PersonDetails newPersonDetails =
        await dataManager.getPersonDetails(_item.id);
    if (mounted) {
      setState(() {
        _personDetails = newPersonDetails;
      });
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _getDetails();
    });
    super.initState();
  }

  void _openHomepage() async {
    if (!await launch(
        _personDetails.homepage != "" ? _personDetails.homepage : "")) {
      throw 'Could not launch ${_personDetails.homepage}';
    }
  }

  void _navigateBack() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor: const Color.fromARGB(215, 255, 255, 255),
                  child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)))),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 55)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                          _personDetails.name != "" ? _personDetails.name : "",
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
                                                ))))),
                              ])),
                      Expanded(
                          child: Column(children: [
                        Center(
                            child: Column(children: [
                          Text(
                              "Born: ${_personDetails.birthday}${_personDetails.deathday != "" ? ' - death:' + _personDetails.deathday : ''}",
                              style: const TextStyle(fontSize: 16)),
                          _personDetails.homepage != ""
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ElevatedButton(
                                      onPressed: _openHomepage,
                                      style: buttonStyle,
                                      child: const Text("Open site")))
                              : const SizedBox(
                                  width: 0,
                                  height: 0,
                                )
                        ])),
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
                                child: Text(
                                    _personDetails.biography != ""
                                        ? _personDetails.biography
                                        : "",
                                    style: const TextStyle(
                                        fontSize: 16, height: 1.4))))),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    _personDetails.gallery.isNotEmpty
                        ? const Text("Gallery",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))
                        : Container(),
                    _personDetails.gallery.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: _personDetails.gallery.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: SizedBox(
                                          height: 160,
                                          width: 90,
                                          child: _personDetails
                                                      .gallery[index] !=
                                                  ""
                                              ? FadeInImage.assetNetwork(
                                                  height: 160,
                                                  width: 90,
                                                  placeholder:
                                                      'assets/images/placeholder_movie.png',
                                                  image:
                                                      '$basePathImages${_personDetails.gallery[index]}',
                                                  fit: BoxFit.cover)
                                              : const SizedBox(
                                                  height: 160,
                                                  width: 90,
                                                  child: FittedBox(
                                                      child: Image(
                                                    image: AssetImage(
                                                        "assets/images/placeholder_movie.png"),
                                                    fit: BoxFit.cover,
                                                  ))))));
                            })
                        : Container(),
                    _item.knownFor.isNotEmpty
                        ? const Text("Appears in",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))
                        : Container(),
                    _item.knownFor.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: _item.knownFor.length,
                            itemBuilder: (context, index) {
                              return GridViewCard(item: _item.knownFor[index]);
                            })
                        : Container(),
                  ]))));
    });
  }
}
