import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_surf/models/tv_show_model.dart';

class TvShowService {
  //API Key
  final String _apiKey = dotenv.env["MY_MOVIE_API_KEY"] ?? "";

  Future<List<TvShowModel>> fetchTvShows() async {
    try {
      //Base URL
      final String baseUrl = "https://api.themoviedb.org/3/tv";

      //Popular TvShows
      final popularResponse = await http.get(
        Uri.parse("$baseUrl/popular?api_key=$_apiKey"),
      );

      //Airing Today TvShows
      final airingTodayResponse = await http.get(
        Uri.parse("$baseUrl/airing_today?api_key=$_apiKey"),
      );

      //Top Rated TvShows
      final topRatedResponse = await http.get(
        Uri.parse("$baseUrl/top_rated?api_key=$_apiKey"),
      );

      if (popularResponse.statusCode == 200 &&
          airingTodayResponse.statusCode == 200 &&
          topRatedResponse.statusCode == 200) {
        final popularData = json.decode(popularResponse.body);
        final airingTodayData = json.decode(airingTodayResponse.body);
        final topRatedData = json.decode(topRatedResponse.body);

        final List<dynamic> popularResult = popularData["results"];
        final List<dynamic> airingTodayResult = airingTodayData["results"];
        final List<dynamic> topRatedResult = topRatedData["results"];

        List<TvShowModel> tvShows = [];

        tvShows.addAll(
          popularResult.map((tvData) => TvShowModel.formJson(tvData)).take(20),
        );

        tvShows.addAll(
          airingTodayResult
              .map((tvData) => TvShowModel.formJson(tvData))
              .take(20),
        );

        tvShows.addAll(
          topRatedResult.map((tvData) => TvShowModel.formJson(tvData)).take(20),
        );

        return tvShows;
      } else {
        throw Exception("Faild to Load TvShows!");
      }
    } catch (error) {
      debugPrint("Error Fetching Tv Shows: $error");
      return [];
    }
  }
}
