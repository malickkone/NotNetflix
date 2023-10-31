

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/services/api-service.dart';
import '../models/movie.dart';

class DataRepository with ChangeNotifier{
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;
  final List<Movie> _upcomingMovieList = [];
  int _upcomingPageIndex = 1;
  final List<Movie> _animationMovies = [];
  int _animationMoviePageIndex = 1;

  List<Movie> get popularMovieList => _popularMovieList;

  List<Movie> get nowPlaying => _nowPlaying;

  List<Movie> get upcomingMovieList => _upcomingMovieList;

  List<Movie> get animationMovies => _animationMovies;

  Future<void> getPopularMovies() async {
    try{
      List<Movie> movies = await apiService.getPopularMovies(pageNumber:_popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    }on Response catch(response){
      debugPrint("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlaying() async {
    try{
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch(response){
      debugPrint("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try{
      List<Movie> movies = await apiService.getUpcomingMovies(pageNumber: _upcomingPageIndex);
      _upcomingMovieList.addAll(movies);
      _upcomingPageIndex++;
      notifyListeners();
    } on Response catch(response){
      debugPrint("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try{
      List<Movie> movies = await apiService.getAnimationMovies(pageNumber: _animationMoviePageIndex);
      _animationMovies.addAll(movies);
      _animationMoviePageIndex++;
      notifyListeners();
    } on Response catch(response){
      debugPrint("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

   Future<Movie> getMovieDetails({required Movie movie}) async{
    try{
      // recuperer les details
      Movie newMovie = await apiService.getMovieDetails(movie: movie);
      // recuper les videos
      newMovie = await apiService.getMovieVideo(movie: newMovie);
      // recuperer le castings
      newMovie = await apiService.getMovieCast(movie: newMovie);
      //recuperer les images associés au film
      newMovie = await apiService.getMovieImages(movie: newMovie);

      return newMovie;

    }on Response catch(response){
      debugPrint("ERROR : ${response.statusCode}");
      rethrow;
    }
   }

  Future<void> initData() async{

    // await getPopularMovies();
    // await getNowPlaying();
    // await getUpcomingMovies();
    // await getAnimationMovies();

    await Future.wait([
       getPopularMovies(),
       getNowPlaying(),
       getUpcomingMovies(),
       getAnimationMovies(),
    ]);
  }
}