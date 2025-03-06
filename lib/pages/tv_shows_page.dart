import 'package:flutter/material.dart';
import 'package:movie_surf/models/tv_show_model.dart';
import 'package:movie_surf/pages/single_tvshow_details_page.dart';
import 'package:movie_surf/services/tv_show_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/tv_show_details_card.dart';

class TvShowsPage extends StatefulWidget {
  const TvShowsPage({super.key});

  @override
  State<TvShowsPage> createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage> {
  List<TvShowModel> _tvShows = [];
  bool _isLoading = true;
  String _error = "";

  //Fetch TvShows
  Future<void> _fetchTvShows() async {
    try {
      List<TvShowModel> tvShows = await TvShowService().fetchTvShows();
      setState(() {
        _tvShows = tvShows;
        _isLoading = false;
      });
    } catch (error) {
      debugPrint("Error: $error");
      setState(() {
        _error = "Faild to Load TvShows";
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tv Shows",
          style: AppTextStyle.kMainTitle.copyWith(
            fontSize: 38,
            color: AppColors.kBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.kBlueColor),
              )
              : _error.isNotEmpty
              ? Center(child: Text(_error, style: AppTextStyle.kBodyText))
              : ListView.builder(
                itemCount: _tvShows.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SingleTvshowDetailsPage(
                                tvShow: _tvShows[index],
                              ),
                        ),
                      );
                    },
                    child: TvShowDetailsCard(tvShow: _tvShows[index]),
                  );
                },
              ),
    );
  }
}
