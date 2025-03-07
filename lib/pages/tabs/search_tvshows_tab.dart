import 'package:flutter/material.dart';
import 'package:movie_surf/models/tv_show_model.dart';
import 'package:movie_surf/pages/single_tvshow_details_page.dart';
import 'package:movie_surf/services/tv_show_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/tv_show_details_card.dart';

class SearchTvshowsTab extends StatefulWidget {
  const SearchTvshowsTab({super.key});

  @override
  State<SearchTvshowsTab> createState() => _SearchTvshowsTabState();
}

class _SearchTvshowsTabState extends State<SearchTvshowsTab> {

  final TextEditingController _searchController = TextEditingController();
  List<TvShowModel> _searchResult = [];
  bool _isLoading = false;
  String _error = "";

  //Method to Search a TvShow
  Future<void> _searchTvShows() async {
    setState(() {
      _isLoading = true;
      _error = "";
    });
    try {
      List<TvShowModel> tvShows = await TvShowService().searchTvShow(
        _searchController.text,
      );
      setState(() {
        _searchResult = tvShows;
      });
    } catch (error) {
      debugPrint("Error: $error");
      setState(() {
        _error = "Fail to Search TvShow";
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
    return Column(
      children: [
        SizedBox(height: AppConstance.kSizedBoxValue),
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
              labelText: "Search a Tv Show",
              labelStyle: AppTextStyle.kBodyText.copyWith(
                // ignore: deprecated_member_use
                color: AppColors.kGeryColor,
              ),
              suffixIcon: IconButton(
                onPressed: _searchTvShows,
                icon: Icon(Icons.search, size: 34, color: AppColors.kBlueColor),
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
            onSubmitted: (value) => _searchTvShows(),
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
        else if (_searchResult.isEmpty)
          Center(
            child: Text(
              "No TvShows Found!, Please Search Here...",
              style: AppTextStyle.kBodyText.copyWith(
                color: AppColors.kGreenColor,
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SingleTvshowDetailsPage(
                                  tvShow: _searchResult[index],
                                ),
                          ),
                        );
                      },
                      child: TvShowDetailsCard(tvShow: _searchResult[index]),
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
    );
  }
}
