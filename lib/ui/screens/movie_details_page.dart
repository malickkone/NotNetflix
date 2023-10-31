// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/action_button.dart';
import 'package:notnetflix/ui/widgets/galerie_card.dart';
import 'package:notnetflix/ui/widgets/movie_info.dart';
import 'package:notnetflix/ui/widgets/my_video_player.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

import '../widgets/casting_card.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataPrivider = Provider.of<DataRepository>(context, listen: false);
    Movie _movie = await dataPrivider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundColor,
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
        ),
        body: newMovie == null
            ? Center(
                child: SpinKitCircle(color: kPrimaryColor),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: newMovie!.videos!.isEmpty
                            ? Center(
                                child: Text(
                                  'pas de video',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              )
                            : MyVideoPlayer(movieId: newMovie!.videos!.first)),
                    MovieInfo(movie: newMovie!),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        label: 'Lecture',
                        icon: Icons.play_arrow,
                        bgColor: Colors.white,
                        color: kBackGroundColor),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        label: 'Telecharger la vidéo',
                        icon: Icons.download,
                        bgColor: Colors.grey.withOpacity(0.3),
                        color: Colors.white),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      newMovie!.description,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Casting',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: newMovie!.casting!.length,
                          itemBuilder: (context, index) {
                            return newMovie!.casting![index].imageUrl == null
                                ? const Center()
                                : CastingCard(
                                    person: newMovie!.casting![index]);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Galerie',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newMovie!.images!.length,
                        itemBuilder:(context, index){
                          return GalerieCard(posterPath: newMovie!.images![index]);
                        } ,
                      ),
                    )
                  ],
                ),
              ));
  }
}
