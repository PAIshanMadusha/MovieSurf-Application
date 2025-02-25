import 'package:flutter/material.dart';
import 'package:movie_surf/models/movie_model.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';

class MovieDetailsCard extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailsCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppConstance.kPaddingValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.kMovieCardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlueColor,
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstance.kPaddingValue),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              movie.title,
              style: AppTextStyle.kMovieTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "Release Date: ${movie.releaseDate}".toUpperCase(),
              style: AppTextStyle.kBodyText.copyWith(
                color: AppColors.kGreenColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "Language: ${movie.originalLanguage}",
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
              movie.overview,
              textAlign: TextAlign.center,
              style: AppTextStyle.kDescriptionText,
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Text(
              "Popularity: ${movie.popularity.toString()}".toUpperCase(),
              style: AppTextStyle.kBodyText.copyWith(
                fontSize: 24,
                color: AppColors.kGeryColor,
              ),
            ),
            SizedBox(height: AppConstance.kSizedBoxValue),
            Container(
              padding: EdgeInsets.all(AppConstance.kPaddingValue),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.kTvShowCardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vote Count: ${movie.voteCount.toString()}",
                    style: AppTextStyle.kBodyText.copyWith(
                      color: AppColors.kGreenColor,
                    ),
                  ),
                  Text(
                    "Vote Average: ${movie.voteAverage.toString()}",
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
