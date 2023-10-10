import 'dart:convert';

import 'package:auth/constants.dart';
import 'package:auth/model/Response.dart';
import 'package:auth/model/user.dart';
import 'package:auth/services/api_request.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  get user => _user;
  final ApiRequest _apiRequest;

  AuthProvider(this._apiRequest);

  initial(SharedPreferences sharedPreferences) {
    print('initial');
    String? username = sharedPreferences.getString("username");
    if (username != null) {
      String? authToken = sharedPreferences.getString("accessToken");
      String? fullName = sharedPreferences.getString("fullName");
      String? phone = sharedPreferences.getString("phone");
      String? jobName = sharedPreferences.getString("jobName");
      String? companyName = sharedPreferences.getString("companyName");
      User user = User(
          username: username,
          fullName: fullName,
          phone: phone,
          jobName: jobName,
          companyName: companyName,
          accessToken: authToken);

      _user = user;
      // Response response = Response(status: true, message: null, data: user);
      notifyListeners();
    } else {
      // response = Response(status: false, message: null, data: null);
      notifyListeners();
    }
  }

  Future<User?> register(User user) async {
    Response? response = await _apiRequest.post(apiRegister, user.toJson());
    if (response != null) {
      if (response.status!) {
        User user = User.fromJson(jsonDecode(response.data!));
        await setStringPreferences("id_customer", user.id!.toString());
        await setStringPreferences("fullName", user.fullName!);
        await setStringPreferences("phone", user.phone!);
        await setStringPreferences("jobName", user.jobName!);
        await setStringPreferences("companyName", user.companyName!);
        await setStringPreferences("username", user.username!);
        await setStringPreferences("accessToken", user.accessToken!);
        _user = user;
        notifyListeners();
      } else {
        notifyListeners();
      }
    }
  }

  Future<Response> login(User user) async {
    Response? response = await _apiRequest.post(apiLogin, user.toJson());
    if (response != null) {
      if (response.status!) {
        User user = User.fromJson(jsonDecode(response.data!));
        await setStringPreferences("id_customer", user.id!.toString());
        await setStringPreferences("fullName", user.fullName!);
        await setStringPreferences("phone", user.phone!);
        await setStringPreferences("jobName", user.jobName!);
        await setStringPreferences("companyName", user.companyName!);
        await setStringPreferences("username", user.username!);
        await setStringPreferences("accessToken", user.accessToken!);
        _user = user;

        notifyListeners();
        return response;
      } else {
        notifyListeners();
        return response;
      }
    }
    return Response(status: false, message: 'success failed', data: null);
  }

  Future<bool> logout() async {
    Response result = await _apiRequest.postWithToken(apiLogout, {});
    print(result);
    if (result.status!) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      _user = null;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future updateAccount(
      String? fullName, String? phone, String? company, String? jobName) async {
    Map<String, dynamic> body = {};
    body["full_name"] = fullName;
    body["phone"] = phone;
    body["company"] = company;
    body["job_name"] = jobName;
    Response response = await _apiRequest.postWithToken(apiUpdateAccount, body);

    if (response.status!) {
      User user = User.fromJson(jsonDecode(response.data!));
      await setStringPreferences("fullName", user.fullName!);
      await setStringPreferences("phone", user.phone!);
      await setStringPreferences("jobName", user.jobName!);
      await setStringPreferences("companyName", user.companyName!);
      _user = user;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }
}
