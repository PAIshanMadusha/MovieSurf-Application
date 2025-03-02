import 'package:flutter/material.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:movie_surf/services/movie_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/movie_details_card.dart';

class SingleMovieDetailsPage extends StatefulWidget {
  MovieModel movie;
  SingleMovieDetailsPage({super.key, required this.movie});

  @override
  State<SingleMovieDetailsPage> createState() => _SingleMovieDetailsPageState();
}

class _SingleMovieDetailsPageState extends State<SingleMovieDetailsPage> {
  List<MovieModel> _similarMovies = [];
  List<MovieModel> _recommendedMovies = [];
  List<String> _movieImages = [];

  bool _isLoadingSimilarMovies = true;
  bool _isLoadingRecommendedMovies = true;
  bool _isLoadingMovieImages = true;

  //Fetch Similar Movies
  Future<void> _fetchSimilarMovies() async {
    try {
      List<MovieModel> fetchedMovies = await MovieService().fetchSimilarMovies(
        widget.movie.id,
      );
      setState(() {
        _similarMovies = fetchedMovies;
        _isLoadingSimilarMovies = false;
      });
    } catch (error) {
      debugPrint("Error from Similar Movies: $error");
      setState(() {
        _isLoadingSimilarMovies = false;
      });
    }
  }

  //Fetch Recommended Movies
  Future<void> _fetchRecommendedMovies() async {
    try {
      List<MovieModel> fetchedMovies = await MovieService()
          .fetchRecommendedMovies(widget.movie.id);
      setState(() {
        _recommendedMovies = fetchedMovies;
        _isLoadingRecommendedMovies = false;
      });
    } catch (error) {
      debugPrint("Error from Recommended Movies: $error");
      setState(() {
        _isLoadingRecommendedMovies = false;
      });
    }
  }

  //Fetch Movie Images
  Future<void> _fetchMovieImages() async {
    try {
      List<String> fetchedMovies = await MovieService().fetchImagesFromMovieId(
        widget.movie.id,
      );
      setState(() {
        _movieImages = fetchedMovies;
        _isLoadingMovieImages = false;
      });
    } catch (error) {
      debugPrint("Error form Movie Images: $error");
      setState(() {
        _isLoadingMovieImages = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSimilarMovies();
    _fetchRecommendedMovies();
    _fetchMovieImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.kBlueColor,
            size: 35,
          ),
        ),
        title: Text(
          widget.movie.title,
          style: AppTextStyle.kMainTitle.copyWith(
            fontSize: 32,
            color: AppColors.kBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "View More Details",
              style: AppTextStyle.kMainTitle.copyWith(
                fontSize: 26,
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            MovieDetailsCard(movie: widget.movie),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: Divider(color: AppColors.kBlueColor),
            ),
            Text(
              "Movie Images",
              style: AppTextStyle.kMainTitle.copyWith(
                fontSize: 26,
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: _buildImageSection(),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: Divider(color: AppColors.kBlueColor),
            ),
            Text(
              "Similar Movies",
              style: AppTextStyle.kMainTitle.copyWith(
                fontSize: 26,
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: _buildMovieSection(
                _similarMovies,
                _isLoadingSimilarMovies,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: Divider(color: AppColors.kBlueColor),
            ),
            Text(
              "Recommended Movies",
              style: AppTextStyle.kMainTitle.copyWith(
                fontSize: 26,
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(
              height: AppConstance.kSizedBoxValue,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: _buildMovieSection(
                _recommendedMovies,
                _isLoadingRecommendedMovies,
              ),
            ),
            SizedBox(
              height: AppConstance.kSizedBoxValue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (_isLoadingMovieImages) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kBlueColor),
      );
    }
    if (_movieImages.isEmpty) {
      return Center(
        child: Text("No Images Found!", style: AppTextStyle.kBodyText),
      );
    }
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: EdgeInsets.only(right: AppConstance.kPaddingValue),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(_movieImages[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieSection(List<MovieModel> movies, bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kBlueColor),
      );
    }
    if (movies.isEmpty) {
      return Center(
        child: Text("No Movies Found!", style: AppTextStyle.kBodyText),
      );
    }
    return SizedBox(
      height: 506,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                widget.movie = movies[index];
                _fetchMovieImages();
                _fetchSimilarMovies();
                _fetchRecommendedMovies();
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: AppConstance.kPaddingValue),
              padding: EdgeInsets.all(AppConstance.kPaddingValue),
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: AppColors.kMovieCardColor,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.kBlueColor.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  movies[index].posterPath != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}",
                          width: double.infinity,
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      )
                      : SizedBox(),
                  SizedBox(height: AppConstance.kSizedBoxValue),
                  Text(
                    movies[index].title,
                    style: AppTextStyle.kMovieTitle.copyWith(fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppConstance.kSizedBoxValue),
                  Text(
                    "Overview".toUpperCase(),
                    style: AppTextStyle.kBodyText.copyWith(
                      fontSize: 15,
                      color: AppColors.kGeryColor,
                    ),
                  ),
                  SizedBox(height: AppConstance.kSizedBoxValue),
                  Text(
                    movies[index].overview,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.kDescriptionText.copyWith(fontSize: 13),
                  ),
                  SizedBox(height: AppConstance.kSizedBoxValue),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
