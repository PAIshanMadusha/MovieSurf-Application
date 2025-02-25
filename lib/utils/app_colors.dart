import 'package:flutter/material.dart';

class AppColors {
  static const Color kGeryColor = Colors.grey;
  static const Color kBlueColor = Colors.blue;
  static const Color kWhiteColor = Colors.white;
  static const Color kRedColor = Colors.red;
  static const Color kGreenColor = Colors.green;

  static const Color kMovieCardColor1 = Color(0xff1A120B);
  static const Color kMovieCardColor2 = Color(0xff03001C);

  static const Gradient kMovieCardColor = LinearGradient(
    colors: [kMovieCardColor1, kMovieCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kTvShowCardColor1 = Color.fromARGB(255, 41, 28, 17);
  static const Color kTvShowCardColor2 = Color.fromARGB(255, 6, 0, 58);

  static const Gradient kTvShowCardColor = LinearGradient(
    colors: [kTvShowCardColor1, kTvShowCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
