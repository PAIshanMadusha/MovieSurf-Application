import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  //Get API Key From .env
  final String _apiKey = dotenv.env["MY_MOVIE_API_KEY"] ?? "";
  final String _baseUrl = "https://api.themoviedb.org/3/movie";

  //Fetch All Upcoming Movies
  Future<List<MovieModel>> fetchUpcomingMovies({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/upcoming?api_key=$_apiKey&page=$page"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data["results"];

        return results
            .map((movieData) => MovieModel.formJson(movieData))
            .toList();
      } else {
        throw Exception("Faild to Load Data!");
      }
    } catch (error) {
      debugPrint("Error Fetcting Upcoming Movies: $error");
      return [];
    }
  }

  //Fetch All NowPlaying Movies
  Future<List<MovieModel>> fetchNowPlayingMovies({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/now_playing?api_key=$_apiKey&page=$page"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data["results"];

        return results
            .map((movieData) => MovieModel.formJson(movieData))
            .toList();
      } else {
        throw Exception("Faild to Load Data!");
      }
    } catch (error) {
      debugPrint("Error Fetching NowPlaying Movies: $error");
      return [];
    }
  }

  //Search Movie by Name
  final String _searchBaseUrl = "https://api.themoviedb.org/3/search/movie";

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse("$_searchBaseUrl?query=$query&api_key=$_apiKey"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data["results"];

        return results
            .map((movieData) => MovieModel.formJson(movieData))
            .toList();
      }else{
        throw Exception("Error Searching Movies!");
      }
    } catch (error) {
      debugPrint("Error Searching Movies: $error");
      throw Exception("Faild to Search Movie: $error");
    }
  }
}
