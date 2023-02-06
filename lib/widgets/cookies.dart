import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

class Cookies {
  Future<List<String>?> getStoredLoginInfo() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('login-info');
  }

  void setStoredLoginInfo(List<String> info) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('login-info', info);
  }

  void deleteInfo() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('login-info');
  }
}
