import 'package:flutter/material.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:movie_surf/services/movie_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/movie_details_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  //Method to Fetch the Upcoming Movies From the API, //Also, Call It in InitState
  Future<void> _fetchMovies() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(microseconds: 500));
    try {
      final newMovies = await MovieService().fetchUpcomingMovies(
        page: _currentPage,
      );
      setState(() {
        if (newMovies.isEmpty) {
          _hasMore = false;
        } else {
          _movies.addAll(newMovies);
          _currentPage++;
        }
      });
    } catch (error) {
      debugPrint("Error: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
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
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MovieSurf", style: AppTextStyle.kMainTitle),
            SizedBox(width: AppConstance.kSizedBoxValue - 4),
            Image.asset(
              "assets/videocamera.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (!_isLoading &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            _fetchMovies();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _movies.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _movies.length) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.kBlueColor),
              );
            }
            final MovieModel movie = _movies[index];
            return MovieDetailsCard(movie: movie);
          },
        ),
      ),
    );
  }
}
