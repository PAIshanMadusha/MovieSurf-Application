import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_surf/pages/now_playing_page.dart';
import 'package:movie_surf/pages/search_movies_tvshows_page.dart';
import 'package:movie_surf/pages/tv_shows_page.dart';
import 'package:movie_surf/services/user_service.dart';
import 'package:movie_surf/utils/app_colors.dart';
import 'package:movie_surf/utils/app_constance.dart';
import 'package:movie_surf/utils/app_text_style.dart';
import 'package:movie_surf/widgets/profile_page_card.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserService _userService = UserService();

  final TextEditingController _nameController = TextEditingController();

  String? _imagePath;
  String? savedName;

  //Pick a Image form Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    String? imagePath = await _userService.pickImage(source);
    if (imagePath != null) {
      await _userService.saveImage(imagePath);
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  //Load Saved Image
  void _loadImage() async {
    String? savedImagePath = await _userService.getImage();
    setState(() {
      _imagePath = savedImagePath;
    });
  }

  //Save UserName
  Future<void> _saveUserName() async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await _userService.saveUserName(newName);
      setState(() {
        savedName = newName;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Name Saved Successfully!",
              style: AppTextStyle.kBodyText,
            ),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Name Cannot be Empty!",
              style: AppTextStyle.kBodyText,
            ),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  //Load UserName
  Future<void> _loadUserName() async {
    final name = await _userService.loadUserName();
    setState(() {
      savedName = name ?? "";
      _nameController.text = savedName!;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImage(); //Load Saved Image When Screen Opens
    _loadUserName(); //Load Saved Name When Screen Opens
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: AppTextStyle.kMainTitle.copyWith(
            fontSize: 38,
            color: AppColors.kBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstance.kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.kGeryColor, width: 3),
                ),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage:
                      _imagePath != null
                          ? FileImage(File(_imagePath!)) as ImageProvider
                          : AssetImage("assets/videocamera.png"),
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.kTvShowCardColor1,
                      ),
                    ),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icon(
                      Icons.photo,
                      color: AppColors.kGreenColor,
                      size: 35,
                    ),
                    label: Text(
                      "Pick",
                      style: AppTextStyle.kBodyText.copyWith(
                        color: AppColors.kGreenColor,
                      ),
                    ),
                  ),
                  // SizedBox(width: AppConstance.kSizedBoxValue * 2),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.kTvShowCardColor1,
                      ),
                    ),
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.kGreenColor,
                      size: 35,
                    ),
                    label: Text(
                      "Take",
                      style: AppTextStyle.kBodyText.copyWith(
                        color: AppColors.kGreenColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              TextField(
                controller: _nameController,
                style: AppTextStyle.kBodyText.copyWith(
                  color: AppColors.kWhiteColor,
                  fontSize: 28,
                  letterSpacing: 4,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  label: Text(
                    "Your Name",
                    style: AppTextStyle.kBodyText.copyWith(
                      color: AppColors.kGeryColor,
                      fontSize: 20,
                    ),
                  ),
                  fillColor: AppColors.kTvShowCardColor1,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColors.kTvShowCardColor2,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: AppColors.kTvShowCardColor2,
                      width: 4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    // ignore: deprecated_member_use
                    AppColors.kGreenColor.withOpacity(0.9),
                  ),
                ),
                onPressed: _saveUserName,
                child: Text(
                  "Save Name",
                  style: AppTextStyle.kBodyText.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Text("If you are interested?", style: AppTextStyle.kMovieTitle),
              SizedBox(height: AppConstance.kSizedBoxValue),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NowPlayingPage()),
                  );
                },
                child: ProfilePageCard(
                  animationImage: "assets/animations/Animation1.json",
                  itemName: "View Popular Movies",
                  icon: Icons.arrow_back_ios,
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TvShowsPage()),
                  );
                },
                child: ProfilePageCard(
                  animationImage: "assets/animations/Animation1.json",
                  itemName: "View Popular Tv Shows",
                  icon: Icons.arrow_back_ios,
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchMoviesTvshowsPage(),
                    ),
                  );
                },
                child: ProfilePageCard(
                  animationImage: "assets/animations/Animation2.json",
                  itemName: "Search for Any Movie or Tv Show",
                  icon: Icons.arrow_back_ios,
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
            ],
          ),
        ),
      ),
    );
  }
}
