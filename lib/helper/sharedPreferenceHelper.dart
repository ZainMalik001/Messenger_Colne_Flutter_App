
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdKey = 'USERIDKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userDisplayNameKey = 'USERDISPLAYNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userProfileImageKey = 'USERPROFILEIMAGEKEY';

  // Save Data

  Future<bool> saveUserId(String getUserId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userDisplayNameKey, getUserDisplayName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserProfilePic(String getUserProfilePic) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userProfileImageKey, getUserProfilePic);
  }

  // Get Data

  Future<String> getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String> getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getUserDisplayName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDisplayNameKey);
  }

  Future<String> getUserEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUserProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileImageKey);
  }




}