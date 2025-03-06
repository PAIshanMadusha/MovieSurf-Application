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
          popularResult.map((tvData) => TvShowModel.formJson(tvData)).take(100),
        );

        tvShows.addAll(
          airingTodayResult
              .map((tvData) => TvShowModel.formJson(tvData))
              .take(100),
        );

        tvShows.addAll(
          topRatedResult
              .map((tvData) => TvShowModel.formJson(tvData))
              .take(100),
        );

        return tvShows;
      } else {
        throw Exception("Faild to Load TvShows!");
      }
    } catch (error) {
      debugPrint("Error Fetching Tv Shows: $error");
      return fetchTvShows();
    }
  }

  //Fetch Images by TvShow Id
  Future<List<String>> fetchImagesFromTvShowId(int tvShowId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$tvShowId/images?api_key=$_apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> backdrops = data["backdrops"];

        //Return the First 10 Images
        return backdrops
            .take(10)
            .map(
              (imageData) =>
                  "https://image.tmdb.org/t/p/w500${imageData["file_path"]}",
            )
            .toList();
      } else {
        throw Exception("Error Fetching Images");
      }
    } catch (error) {
      debugPrint("Error Fetching Images: $error");
      return fetchImagesFromTvShowId(tvShowId);
    }
  }

  //Fetch Similar TvShows
  Future<List<TvShowModel>> fetchSimilarTvShows(int tvShowId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$tvShowId/similar?api_key=$_apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> results = data["results"];

        return results
            .map((tvShowData) => TvShowModel.formJson(tvShowData))
            .toList();
      } else {
        throw Exception("Error with Similar TvShows");
      }
    } catch (error) {
      debugPrint("Faild to Fetch Similar TvShows: $error");
      return fetchSimilarTvShows(tvShowId);
    }
  }

  //Fetch Recomended TvShows
  Future<List<TvShowModel>> fetchRecommendedTvShows(int tvShowId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/$tvShowId/recommendations?api_key=$_apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> results = data["results"];

        return results
            .map((tvShowData) => TvShowModel.formJson(tvShowData))
            .toList();
      }else{
        throw Exception("Error with Recommended TvShows");
      }
    } catch (error) {
      debugPrint("Faild to Fetch Recommended TvShows: $error");
      return fetchRecommendedTvShows(tvShowId);
    }
  }
}
