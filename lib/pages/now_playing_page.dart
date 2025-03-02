import 'package:flutter/material.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:movie_surf/services/movie_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/movie_details_card.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final MovieService _movieService = MovieService();
  List<MovieModel> _movies = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  //Method to Fetch the NowPlaying Movies From the API
  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<MovieModel> fetchedMovies = await _movieService
          .fetchNowPlayingMovies(page: _currentPage);
      setState(() {
        _movies = fetchedMovies;
        _totalPages = 200;
      });
    } catch (error) {
      debugPrint("Error: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //Previous Page
  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchMovies();
    }
  }

  //Next Page
  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
      _fetchMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Now Playing",
          style: AppTextStyle.kMainTitle.copyWith(
            fontSize: 38,
            color: AppColors.kBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? Center(
                child: const CircularProgressIndicator(
                  color: AppColors.kBlueColor,
                ),
              )
              : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length + 1,
                      itemBuilder: (context, index) {
                        if (index > _movies.length - 1) {
                          return _buildPaginationControlles();
                        } else {
                          return MovieDetailsCard(movie: _movies[index]);
                        }
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  //Paginations
  Widget _buildPaginationControlles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _currentPage > 1 ? _previousPage : null,
          child: Icon(
            Icons.arrow_back_sharp,
            size: 35,
            color: AppColors.kGreenColor,
          ),
        ),
        SizedBox(width: AppConstance.kSizedBoxValue),
        Text(
          "Page $_currentPage of $_totalPages",
          style: AppTextStyle.kMovieTitle.copyWith(
            color: AppColors.kWhiteColor,
            fontSize: 25,
          ),
        ),
        SizedBox(width: AppConstance.kSizedBoxValue),
        ElevatedButton(
          onPressed: _currentPage < _totalPages ? _nextPage : null,
          child: Icon(
            Icons.arrow_forward_sharp,
            size: 35,
            color: AppColors.kGreenColor,
          ),
        ),
      ],
    );
  }
}
