import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceService {
  static const String bearerToken = "BEARERTOKEN";
  static const String phoneNumber = "PHONENUMBER";
  SharedPreferences? pref;
  init() async {
    pref = await SharedPreferences.getInstance();
  }
  setBearerToken(String value) {
    pref?.setString(bearerToken, value);
    debugPrint("Bearer Token stored successfully");
  }
  String getBearerToken() {
    return pref?.getString(bearerToken) ?? "";
  }
  setUserPhone(String value) {
    pref?.setString(phoneNumber, value);
    debugPrint("Bearer Token stored successfully");
  }
  String getUserPhone() {
    return pref?.getString(phoneNumber) ?? "";
  }
  clearData() async {
    pref?.clear();
  }

}
