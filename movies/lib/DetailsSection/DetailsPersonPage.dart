import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/DetailsSection/DetailsMoviePage.dart';
import 'package:movies/DetailsSection/DetailsSeriePage.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/interfaces/PersonDetails.dart';
import 'package:movies/models/providers/ProviderFavs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

  final ButtonStyle homepageStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Colors.redAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
    if (!await launch(_personDetails.homepage))
      throw 'Could not launch ${_personDetails.homepage}';
  }

  void _launchTrailer() async {
    // if (!await launch('$youtubePath${personDetails.}')) throw 'Could not launch $youtubePath${personDetails.}';
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
                    const Padding(padding: EdgeInsets.only(top: 75)),
                    InkWell(
                        onTap: _launchTrailer,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              height: 240,
                              child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    FittedBox(
                                        child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/placeholder_movie.png',
                                            image:
                                                '$basePathImages${_item.backdropPath}'),
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
                      child: Text(_personDetails.name,
                          style: const TextStyle(
                              fontSize: 28, color: Colors.white70)),
                    ),
                    Row(children: [
                      // Padding(
                      //     padding: const EdgeInsets.only(right: 5),
                      // child: Stack(
                      //   alignment: Alignment.bottomRight,
                      //   children: [
                      //   ClipRRect(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       child: Container(
                      //           height: 170,
                      //           child: FadeInImage.assetNetwork(
                      //               placeholder:
                      //                   'assets/images/movie_poster_placeholder.jpeg',
                      //               image:
                      //                   '$basePathImages${_item.posterPath}'))),
                      //   Container(
                      //       child: ClipOval(
                      //         child: CircularPercentIndicator(
                      //           radius: 30,
                      //           lineWidth: 6,
                      //           backgroundColor: Colors.white,
                      //           fillColor: Colors.grey.withOpacity(0.8),
                      //           progressColor: ColorSelect.customBlue,
                      //           percent: _personDetails.voteAverage.ceilToDouble() / 10,
                      //           center: Text(_personDetails.voteAverage.toString(), style: const TextStyle(color: ColorSelect.customBlue, fontSize: 18, fontWeight: FontWeight.w600)),
                      //       ))),
                      // ])),
                      Expanded(
                          child: Column(children: [
                        Center(
                            child: Column(children: [
                          // Text("Length: ${_personDetails.runtime} minutes"),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                  onPressed: _openHomepage,
                                  style: homepageStyle,
                                  child: const Text("Open site"))),
                        ])),
                        // Row(children: [
                        //   _personDetails.watchProviders.isNotEmpty ? GridView.builder(
                        //       padding:
                        //           const EdgeInsets.only(top: 15, bottom: 15),
                        //       gridDelegate:
                        //           const SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 2),
                        //       shrinkWrap: true,
                        //       physics: const ScrollPhysics(),
                        //       itemCount: _personDetails.watchProviders.length,
                        //       itemBuilder: (context, index) {
                        //         return ClipRRect(
                        //                 borderRadius:
                        //                     BorderRadius.circular(10.0),
                        //                 child: Container(
                        //                     height: 60,
                        //                     width: 60,
                        //                     color: Colors.white,
                        //                     child: FadeInImage.assetNetwork(
                        //                         placeholder: '',
                        //                         image:
                        //                             '$basePathImages${_personDetails.watchProviders[index].logoPath}')));
                        //       }): Container()
                        // ])
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
                        child: Text(_personDetails.biography,
                            style: const TextStyle(fontSize: 16, height: 1.3))))),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    // _personDetails.gallery.isNotEmpty
                    //     ? const Text("Gallery",
                    //         style: TextStyle(
                    //             fontSize: 18, fontWeight: FontWeight.w600))
                    //     : Container(),
                    // _personDetails.gallery.isNotEmpty
                    //     ? GridView.builder(
                    //         padding: const EdgeInsets.only(top: 15, bottom: 20),
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2),
                    //         shrinkWrap: true,
                    //         physics: const ScrollPhysics(),
                    //         itemCount: _personDetails.gallery.length,
                    //         itemBuilder: (context, index) {
                    //           return (ClipRRect(
                    //               borderRadius: BorderRadius.circular(10.0),
                    //               child: Container(
                    //                   height: 60,
                    //                   width: 110,
                    //                   child: FadeInImage.assetNetwork(
                    //                       placeholder:
                    //                           'assets/images/placeholder_movie.png',
                    //                       image:
                    //                           '$basePathImages${_personDetails.gallery[index]}'))));
                    //         })
                    //     : Container(),
                    // _personDetails.similars.isNotEmpty
                    //     ? const Text("Suggested",
                    //         style: TextStyle(
                    //             fontSize: 20, fontWeight: FontWeight.w600))
                    //     : Container(),
                    // _personDetails.similars.isNotEmpty
                    //     ? GridView.builder(
                    //         padding: const EdgeInsets.only(top: 15, bottom: 20),
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2),
                    //         shrinkWrap: true,
                    //         physics: const ScrollPhysics(),
                    //         itemCount: _personDetails.similars.length,
                    //         itemBuilder: (context, index) {
                    //           return GridViewCard(
                    //               item: _personDetails.similars[index]);
                    //         })
                    //     : Container(),
                  ]))));
    });
  }
}
