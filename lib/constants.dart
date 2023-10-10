import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';

const String apiImage = "http://10.0.2.2:8000/";
const String api = "http://10.0.2.2:8000/api/user/";
const String apiPassword = "password-of-api-be-defecult";

const String apiRegister = api + 'register';
const String apiLogin = api + 'login';
const String apiLogout = api + 'logout';
const String apiUpdateAccount = api + 'update_account';
const String apiGetData = api + 'getData';
const String apiAddAdsCampaign = api + 'add_ads_campaign';
const String apiGetAdsCampaign = api + 'get_ads_Campaign';
const String apiGetContract = api + 'get_contracts';
const String apiAddConfirmPay = api + 'add_confirm_pay';

class AppColors {
  AppColors._();
  // 38f8d4 , 01040d , 43ea80 ,
  static const Color primaryColor = Color(0xff43ea80);

  static const Color darkPrimaryColor =
      Color(0xff01040d); // for appbar or bottom bar
  // static const Color assentColor = Color(0xff38f8d4);
  static const Color assentColor = Color(0xffdafada);
  static const Color textColorBlack = Colors.black;
  static const Color textColorWhite = Colors.white;
  static const Color buttonColor = Color(0xffdafada);
  static const Color iconColor = Color(0xff01040d);
  static const Color cardColor = Color(0xffdafada);
  static const Color backgroundColor = Color(0xfff1f1f1);
  static const Color errorColor = Color(0xffee2b2b);

  // don't change this color
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color grayColor = Color(0xffdddfe6);
}

// function for translate text
String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key)!;
}

Future setStringPreferences(String key, String value) async {
  SharedPreferences _sh = await SharedPreferences.getInstance();
  await _sh.setString(key, value);
}

Future<String?> getStringPreferences(String key) async {
  SharedPreferences _sh = await SharedPreferences.getInstance();
  return _sh.getString(key);
}


Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString("lan", languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString("lan") ?? "ar";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case "en":
      return Locale("en", 'US');
    case "ar":
      return Locale("ar", "AR");
    default:
      return Locale("en", 'US');
  }
}

