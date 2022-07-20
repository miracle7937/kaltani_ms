import 'dart:convert';

import 'package:kaltani_ms/logic/model/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUser(Map user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userData', jsonEncode(user));
}

Future<AuthResponse> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic value = prefs.get('userData');
  var response = jsonDecode(value);
  return AuthResponse.fromJson(response);
}

Future<String> getUserToke() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic value = prefs.get('userData');
  if (value == null) {
    return "";
  }
  AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(value));
  return authResponse.token ?? "";
}

Future<String?> getUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic value = prefs.get('userData');
  AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(value));
  return authResponse.user?.email;
}

Future<bool> clearUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove('userData');
}
