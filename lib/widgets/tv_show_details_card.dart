import 'package:flutter/material.dart';
import 'package:movie_surf/models/tv_show_model.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';

class TvShowDetailsCard extends StatelessWidget {
  final TvShowModel tvShow;

  const TvShowDetailsCard({super.key, required this.tvShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppConstance.kPaddingValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      child: Padding(
        padding: EdgeInsets.all(AppConstance.kPaddingValue),
        child: Column(
          children: [
            tvShow.posterPath == null
                ? SizedBox()
                : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${tvShow.posterPath}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              tvShow.name,
              style: AppTextStyle.kMovieTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "First Air Date: ${tvShow.firstAirDate}".toUpperCase(),
              style: AppTextStyle.kBodyText.copyWith(
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "Language: ${tvShow.originalLanguage}",
              style: AppTextStyle.kBodyText,
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "Overview".toUpperCase(),
              style: AppTextStyle.kBodyText.copyWith(
                fontSize: 24,
                color: AppColors.kGeryColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              tvShow.overview,
              textAlign: TextAlign.center,
              style: AppTextStyle.kDescriptionText,
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Container(
              padding: EdgeInsets.all(AppConstance.kPaddingValue),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.kMovieCardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popularity: ${tvShow.popularity.toString()}",
                    style: AppTextStyle.kBodyText.copyWith(
                      color: AppColors.kGreenColor,
                    ),
                  ),
                  Text(
                    "Vote Average: ${tvShow.voteAverage.toString()}",
                    style: AppTextStyle.kBodyText.copyWith(
                      color: AppColors.kGreenColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
          ],
        ),
      ),
    );
  }
}
