import 'package:flutter/material.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/movie_card.dart';
import 'package:notnetflix/ui/widgets/movie_category.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        leading: Image.asset("assets/images/netflix_logo_2.png"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: dataProvider.popularMovieList.isEmpty
                ? const Center()
                : MovieCArd(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            label: 'Tendances Actuelles',
            movieListe: dataProvider.popularMovieList,
            imageHeight: 160,
            imageWidth: 110,
            callBack: dataProvider.getPopularMovies),
          MovieCategory(
            label: 'Actuellemet au ciné',
            movieListe: dataProvider.nowPlaying,
            imageHeight: 320,
            imageWidth: 220,
            callBack: dataProvider.getNowPlaying),
          MovieCategory(
            label: 'Ils arrivent bientot',
            movieListe: dataProvider.upcomingMovieList,
            imageHeight: 160,
            imageWidth: 110,
            callBack: dataProvider.getUpcomingMovies),
          MovieCategory(
            label: 'Animation',
            movieListe: dataProvider.animationMovies,
            imageHeight: 320,
            imageWidth: 220,
            callBack: dataProvider.getAnimationMovies),

          //////////////////////////////////////////////////////
        ],
      ),
    );
  }
}
