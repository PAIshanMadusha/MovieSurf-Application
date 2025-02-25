import 'package:flutter/material.dart';
import 'package:movie_surf/utils/app_colors.dart';

class AppTextStyle {

  static const TextStyle kMainTitle = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 58,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static const TextStyle kMovieTitle = TextStyle(
    color: AppColors.kBlueColor,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle kBodyText = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle kDescriptionText = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}