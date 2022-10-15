import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._();

  static const _isLoggedIn = "is_logged_in";
  static const _userInfo = "user_info";
  static const _token = "token";


  static Future<void> setAuthenticationToken(String authToken) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(_token, authToken);
  }

  static Future<String> getAuthenticationToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString(_token);
    return token!;
  }


  static Future<void> setLoginStatus(bool loginStatus) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool(_isLoggedIn, loginStatus);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? loginStatus = localStorage.getBool(_isLoggedIn) ?? false;
    return loginStatus;
  }

  static Future<void> logoutClearPreferences() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove(_isLoggedIn);
    await localStorage.remove(_token);
  }
}
