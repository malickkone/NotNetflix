// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/movie.dart';
import 'movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieListe;
  final double imageHeight;
  final double imageWidth;
  final Function callBack;
  const MovieCategory({
    Key? key,
    required this.label,
    required this.movieListe,
    required this.imageHeight,
    required this.imageWidth,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const SizedBox(height: 15,),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold  
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: imageHeight,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                final currentPosition = notification.metrics.pixels;
                final maxPositon = notification.metrics.maxScrollExtent;
                if(currentPosition >= maxPositon/2){
                  callBack();
                }
                return true;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieListe.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: imageWidth,
                    child: movieListe.isEmpty  
                     ? Center(child: Text(index.toString())) 
                     : MovieCArd(movie: movieListe[index])
                  );
                }
              ),
            ),
          ),
      ],
    );
  }
}
