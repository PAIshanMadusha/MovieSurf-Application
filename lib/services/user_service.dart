import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final ImagePicker _picker = ImagePicker();

  //Pick an Image form the Gallery or Camera
  Future<String?> pickImage(ImageSource source) async{
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null){
      return image.path;
    }
    return null;
  }

  //Save the Image Path to SharedPreferences
  Future<void> saveImage(String imagePath) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', imagePath);
  }

  //Get the Save Image Path
  Future<String?> getImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image');
  }

  //User NameKey
  static const String _userNameKey = 'user_name';

  //Save UserName to SharedPreferences
  Future<void> saveUserName(String name) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name.trim());
  }

  //Load UserName from the SharedPreferences
  Future<String?> loadUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  } 
}