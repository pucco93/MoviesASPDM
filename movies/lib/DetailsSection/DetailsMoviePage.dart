import 'package:flutter/material.dart';
import 'package:movies/AppBar/AppBar.dart';
import 'package:movies/Constants/Constants.dart';
import 'package:movies/data_manager/DataManager.dart';
import 'package:movies/models/interfaces/MovieDetails.dart';
import 'package:movies/models/providers/ProviderFavs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsMoviePage extends StatefulWidget {
  const DetailsMoviePage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  State<DetailsMoviePage> createState() => _DetailsMoviePageState();
}

class _DetailsMoviePageState extends State<DetailsMoviePage> {
  DataManager dataManager = DataManager();
  dynamic get _item => widget.item;
  MovieDetails _movieDetails = initialMovieDetails;

  void _getDetails() async {
    MovieDetails newMovieDetails = await dataManager.getMovieDetails(_item.id);
    setState(() {
      _movieDetails = newMovieDetails;
    });
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  void _launchTrailer() async {
  // if (!await launch('$youtubePath${movieDetails.}')) throw 'Could not launch $youtubePath${movieDetails.}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFavs>(builder: (context, favProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: const CustomAppBar(),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 75)),
                    InkWell(onTap: _launchTrailer,
                      child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                          height: 300,
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
                                    height: 300,
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
                                    child: const Icon(Icons.play_arrow_outlined,
                                        size: 120, color: Colors.white70))
                              ],
                              fit: StackFit.expand)),
                    )
      ),
      Text(_movieDetails.title, style: const TextStyle(fontSize: 28, color: Colors.white70))
      ]))));
    });
  }
}
