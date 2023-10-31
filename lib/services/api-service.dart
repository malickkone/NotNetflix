
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String,dynamic>? params}) async {
    String _url = api.baseURL + path;

    Map<String, dynamic> _params = {
      'api_key' : api.apikey,
      'language' : 'fr-FR'
    };

    if(params != null){
      _params.addAll(params);
    }

    final response = await dio.get(_url, queryParameters: _params);
    
    if (response.statusCode == 200){
      return response;
    }else{
      throw response;
    }
  }
/// get popular movies
  Future<List<Movie>> getPopularMovies({required int pageNumber}) async{
    Response response = await getData('/movie/popular', params: {'page': pageNumber});
    if(response.statusCode == 200){
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for(Map<String, dynamic> json in results){
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    }
    else{
      throw response;
    }
  }
/// get movies playing now
  Future <List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await  getData('/movie/now_playing', params: {'page': pageNumber});
    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json){
        return Movie.fromJson(json);
      }).toList();
      return movies;
    }
    else{
      throw response;
    }
  }

  /// get upcoming movies
  Future <List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await  getData('/movie/upcoming', params: {'page': pageNumber});
    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json){
        return Movie.fromJson(json);
      }).toList();
      return movies;
    }
    else{
      throw response;
    }
  }

  Future <List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await  getData('/discover/movie', params: {
      'page': pageNumber,
      'with_genres':'16'
    });
    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json){
        return Movie.fromJson(json);
      }).toList();
      return movies;
    }
    else{
      throw response;
    }
  }  

  Future<Movie> getMovieDetails({required Movie movie}) async{
    Response response = await getData('/movie/${movie.id}');
    if(response.statusCode == 200){
      Map<String, dynamic> _data = response.data;   
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average']
      );

      return newMovie;
    }
    else{
      throw response;
    }
  }

  Future<Movie> getMovieVideo({required Movie movie}) async{
    Response response = await getData('/movie/${movie.id}/videos');
    if(response.statusCode == 200){
      Map _data = response.data;
      List<String> videokeys =  _data['results'].map<String>((dynamic videoJson){
        return videoJson['key'] as String;
      }).toList();

      return movie.copyWith(videos: videokeys);
    }
    else{
      throw response;
    }
  }

  Future<Movie> getMovieCast({required Movie movie}) async{
    Response response = await getData('/movie/${movie.id}/credits');
    if(response.statusCode == 200){
      Map _data = response.data;
      List<Person> _casting = _data['cast'].map<Person>((json){
        return Person.fromJson(json) ;  
      }).toList();

      return movie.copyWith(casting: _casting);
    }
    else{
      throw response;
    }
  }

  Future<Movie> getMovieImages({ required Movie movie}) async{
    Response response = await getData('/movie/${movie.id}/images', params: {'include_image_language': 'null'});
    if(response.statusCode == 200){
      Map _data = response.data;
      List<String> _images = _data['backdrops'].map<String>((imageJson){
        return imageJson['file_path'] as String;
      }).toList();

      return movie.copyWith(images: _images);
    }
    else{
      throw response;
    } 
  }
}