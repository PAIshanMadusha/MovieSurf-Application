import 'package:flutter/material.dart';
import 'package:movie_surf/models/tv_show_model.dart';
import 'package:movie_surf/services/tv_show_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/tv_show_details_card.dart';

// ignore: must_be_immutable
class SingleTvshowDetailsPage extends StatefulWidget {
  TvShowModel tvShow;
  SingleTvshowDetailsPage({super.key, required this.tvShow});

  @override
  State<SingleTvshowDetailsPage> createState() =>
      _SingleTvshowDetailsPageState();
}

class _SingleTvshowDetailsPageState extends State<SingleTvshowDetailsPage> {
  List<String> _tvShowImages = [];
  List<TvShowModel> _similarTvShows = [];
  List<TvShowModel> _recommendedTvShows = [];

  bool _isLoadingTvshowImages = true;
  bool _isLoadingSimilarTvShows = true;
  bool _isLoadingRecommendedTvShows = true;

  //Fetch Tvshow Images
  Future<void> _fetchTvshowImages() async {
    try {
      List<String> fetchedTvshows = await TvShowService()
          .fetchImagesFromTvShowId(widget.tvShow.id);
      setState(() {
        _tvShowImages = fetchedTvshows;
        _isLoadingTvshowImages = false;
      });
    } catch (error) {
      debugPrint("Error form Tvshow Images: $error");
      setState(() {
        _isLoadingTvshowImages = false;
      });
    }
  }

  //Fetch Similar TvShows
  Future<void> _fetchSimilarTvShows() async {
    try {
      List<TvShowModel> fetchedTvShows = await TvShowService()
          .fetchSimilarTvShows(widget.tvShow.id);
      setState(() {
        _similarTvShows = fetchedTvShows;
        _isLoadingSimilarTvShows = false;
      });
    } catch (error) {
      debugPrint("Error from Similar TvShows: $error");
      setState(() {
        _isLoadingSimilarTvShows = false;
      });
    }
  }

  //Fetch Recommended TvShows
  Future<void> _fetchRecommendedShows() async {
    try {
      List<TvShowModel> fetchedTvShows = await TvShowService()
          .fetchRecommendedTvShows(widget.tvShow.id);
      setState(() {
        _recommendedTvShows = fetchedTvShows;
        _isLoadingRecommendedTvShows = false;
      });
    } catch (error) {
      debugPrint("Error form Recommended TvShows: $error");
      setState(() {
        _isLoadingRecommendedTvShows = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTvshowImages();
    _fetchSimilarTvShows();
    _fetchRecommendedShows();
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
          widget.tvShow.name,
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
            TvShowDetailsCard(tvShow: widget.tvShow),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstance.kPaddingValue,
                right: AppConstance.kPaddingValue,
              ),
              child: Divider(color: AppColors.kBlueColor),
            ),
            Text(
              "Tv Show Images",
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
              "Similar Tv Shows",
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
              child: _buildTvShowsSection(
                _similarTvShows,
                _isLoadingSimilarTvShows,
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
              "Recommended Tv Shows",
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
              child: _buildTvShowsSection(
                _recommendedTvShows,
                _isLoadingRecommendedTvShows,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (_isLoadingTvshowImages) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kBlueColor),
      );
    }
    if (_tvShowImages.isEmpty) {
      return Center(
        child: Text("No Images Found!", style: AppTextStyle.kBodyText),
      );
    }
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tvShowImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: EdgeInsets.only(right: AppConstance.kPaddingValue),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(_tvShowImages[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTvShowsSection(List<TvShowModel> tvShows, bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kBlueColor),
      );
    }
    if (tvShows.isEmpty) {
      return Center(
        child: Text("No Tv Shows Found!", style: AppTextStyle.kBodyText),
      );
    }
    return SizedBox(
      height: 506,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvShows.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.tvShow = tvShows[index];
                _fetchTvshowImages();
                _fetchSimilarTvShows();
                _fetchRecommendedShows();
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: AppConstance.kPaddingValue),
              padding: EdgeInsets.all(AppConstance.kPaddingValue),
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: AppColors.kTvShowCardColor,
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
                  tvShows[index].posterPath != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/${tvShows[index].posterPath}",
                          width: double.infinity,
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      )
                      : SizedBox(),
                  SizedBox(height: AppConstance.kSizedBoxValue),
                  Text(
                    tvShows[index].name,
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
                    tvShows[index].overview,
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
