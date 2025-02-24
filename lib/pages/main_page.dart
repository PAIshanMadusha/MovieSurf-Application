import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_surf/pages/home_page.dart';
import 'package:movie_surf/pages/now_playing_page.dart';
import 'package:movie_surf/pages/search_movies_page.dart';
import 'package:movie_surf/pages/tv_shows_page.dart';
import 'package:movie_surf/utils/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final _pages = [
    const HomePage(),
    const NowPlayingPage(),
    const TvShowsPage(),
    const SearchMoviesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/house.svg",
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0
                    ? AppColors.kBlueColor
                    : AppColors.kGeryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/circleplay.svg",
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1
                    ? AppColors.kBlueColor
                    : AppColors.kGeryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Now Playing",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/tvplay.svg",
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2
                    ? AppColors.kBlueColor
                    : AppColors.kGeryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Tv Shows",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/search.svg",
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3
                    ? AppColors.kBlueColor
                    : AppColors.kGeryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Search",
          ),
        ],
        selectedItemColor: AppColors.kBlueColor,
        unselectedItemColor: AppColors.kGeryColor,
        selectedLabelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
