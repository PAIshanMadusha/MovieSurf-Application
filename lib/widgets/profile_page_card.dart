import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';

class ProfilePageCard extends StatelessWidget {
  final String animationImage;
  final String itemName;
  final IconData icon;
  const ProfilePageCard({
    super.key,
    required this.animationImage,
    required this.itemName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstance.kPaddingValue),
      width: MediaQuery.of(context).size.width * double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: AppColors.kMovieCardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kTvShowCardColor2,
            blurRadius: 3,
            spreadRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: AppColors.kGreenColor),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.52,
            child: Text(
              itemName,
              style: AppTextStyle.kBodyText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          Lottie.asset(
            animationImage,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          SizedBox(width: AppConstance.kSizedBoxValue),
        ],
      ),
    );
  }
}
