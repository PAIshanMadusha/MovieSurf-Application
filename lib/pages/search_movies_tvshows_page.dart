import 'package:flutter/material.dart';
import 'package:movie_surf/pages/tabs/search_movies_tab.dart';
import 'package:movie_surf/pages/tabs/search_tvshows_tab.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_text_style.dart';

class SearchMoviesTvshowsPage extends StatefulWidget {
  const SearchMoviesTvshowsPage({super.key});

  @override
  State<SearchMoviesTvshowsPage> createState() =>
      _SearchMoviesTvshowsPageState();
}

class _SearchMoviesTvshowsPageState extends State<SearchMoviesTvshowsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Search Movies or Tv Shows",
            style: AppTextStyle.kMainTitle.copyWith(
              fontSize: 27,
              color: AppColors.kBlueColor,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.kGreenColor,
            indicatorWeight: 4,
            labelStyle: AppTextStyle.kMovieTitle.copyWith(
              color: AppColors.kGreenColor,
              fontSize: 24,
            ),
            unselectedLabelStyle: AppTextStyle.kMovieTitle.copyWith(
              color: AppColors.kWhiteColor,
              fontSize: 24,
            ),
            tabs: [Tab(text: "Movie"), Tab(text: "Tv Show")],
          ),
        ),
        body: TabBarView(children: [SearchMoviesTab(), SearchTvshowsTab()]),
      ),
    );
  }
}
