// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/ui/screens/movie_details_page.dart';

import '../../models/movie.dart';

class MovieCArd extends StatelessWidget {
  final Movie movie;
  const MovieCArd({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return MovieDetailsPage(movie: movie);
        }));
      },
      child: CachedNetworkImage(
        imageUrl: movie.posterURL(),
        fit: BoxFit.cover ,
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        )
      ),
    );
  }
}
