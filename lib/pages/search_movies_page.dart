import 'package:flutter/material.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:movie_surf/pages/single_movie_details_page.dart';
import 'package:movie_surf/services/movie_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/movie_details_card.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MovieModel> _searchResults = [];
  bool _isLoading = false;
  String _error = "";

  //Method to Search a Movie
  Future<void> _searchMovies() async {
    setState(() {
      _isLoading = true;
      _error = "";
    });
    try {
      List<MovieModel> movies = await MovieService().searchMovies(
        _searchController.text,
      );
      setState(() {
        _searchResults = movies;
      });
    } catch (error) {
      debugPrint("Error: $error");
      setState(() {
        _error = "Fail to Search the Movie";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Movies",
          style: AppTextStyle.kMainTitle.copyWith(
            fontSize: 38,
            color: AppColors.kBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppConstance.kPaddingValue,
              right: AppConstance.kPaddingValue,
              top: AppConstance.kPaddingValue,
            ),
            child: TextField(
              controller: _searchController,
              style: AppTextStyle.kBodyText,
              decoration: InputDecoration(
                labelText: "Search a Movie",
                labelStyle: AppTextStyle.kBodyText.copyWith(
                  // ignore: deprecated_member_use
                  color: AppColors.kGeryColor,
                ),
                suffixIcon: IconButton(
                  onPressed: _searchMovies,
                  icon: Icon(
                    Icons.search,
                    size: 34,
                    color: AppColors.kBlueColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.kBlueColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: AppColors.kBlueColor, width: 3),
                ),
                fillColor: Colors.transparent,
                filled: true,
              ),
              onSubmitted: (value) => _searchMovies(),
            ),
          ),
          SizedBox(height: AppConstance.kSizedBoxValue),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.kBlueColor),
            )
          else if (_error.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(AppConstance.kPaddingValue),
              child: Text(
                _error,
                style: AppTextStyle.kBodyText.copyWith(
                  color: AppColors.kRedColor,
                ),
              ),
            )
          else if (_searchResults.isEmpty)
            Center(
              child: Text(
                "No Movies Found!, Please Search Here...",
                style: AppTextStyle.kBodyText.copyWith(
                  color: AppColors.kGreenColor,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SingleMovieDetailsPage(
                                    movie: _searchResults[index],
                                  ),
                            ),
                          );
                        },
                        child: MovieDetailsCard(movie: _searchResults[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppConstance.kPaddingValue,
                          right: AppConstance.kPaddingValue,
                        ),
                        child: Divider(color: AppColors.kBlueColor),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
