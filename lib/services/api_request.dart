import 'dart:convert';

import 'package:auth/model/Response.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ApiRequest {
  static ApiRequest? _instance;

  ApiRequest._() {
    // initialization
  }

  factory ApiRequest() {
    _instance ??= ApiRequest._();
    return _instance!;
  }

  Future<Response?> post(String url, Map<String, dynamic> body) async {
    body['api_password'] = apiPassword;
    print('post');
    http.Response result = await http.post(
      Uri.parse(url),
      body: body,
    );
    if (result.statusCode == 200) {
      print(result.statusCode);
      print(result.body);
      Map<String, dynamic> json = jsonDecode(result.body);
      Response response = Response.fromJson(json);
      return response;
    } else {
      Map<String, dynamic> json = jsonDecode(result.body);
      Response response = Response.fromJson(json);
      return response;
    }
  }

  Future<Response> postWithToken(String url, Map<String, dynamic> body) async {
    String? authToken = await getStringPreferences("accessToken");

    body['api_password'] = apiPassword;
    if (authToken == null) {
      return Response(status: false, message: 'invalid', data: null);
    }

    http.Response result = await http.post(
      Uri.parse(url),
      headers: {
        'auth_token': authToken,
      },
      body: body,
    );
    if (result.statusCode == 200) {
      print(result.statusCode);
      print(result.body);
      Map<String, dynamic> json = jsonDecode(result.body);
      Response response = Response.fromJson(json);
      return response;
    } else {
      Map<String, dynamic> json = jsonDecode(result.body);
      Response response = Response.fromJson(json);
      return response;
    }
  }

  Future<Response> addAdsCampaign(
      Map<String, String> body, String? filepath) async {
    String? authToken = await getStringPreferences("accessToken");
    if (authToken == null) {
      return Response(status: false, message: 'فشل إضافة الطلب ', data: null);
    }
    body['api_password'] = apiPassword;
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'auth_token': authToken,
    };
    http.MultipartRequest request;
    if (filepath == null) {
      request = http.MultipartRequest('POST', Uri.parse(apiAddAdsCampaign))
        ..fields.addAll(body)
        ..headers.addAll(headers);
    } else {
      request = http.MultipartRequest('POST', Uri.parse(apiAddAdsCampaign))
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath));
    }

    var response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
      return Response(
          status: true, message: 'تم إضافة الطلب بنجاح', data: null);
    } else {
      return Response(status: false, message: 'فشل إضافة الطلب ', data: null);
    }
  }

  Future<Response> sendConfirmPay(
      Map<String, String> body, String? filepath) async {
    String? authToken = await getStringPreferences("accessToken");
    if (authToken == null) {
      return Response(status: false, message: 'فشل إضافة الطلب ', data: null);
    }
    body['api_password'] = apiPassword;
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'auth_token': authToken,
    };
    http.MultipartRequest request;
    if (filepath != null) {
      request = http.MultipartRequest('POST', Uri.parse(apiAddConfirmPay))
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath));

      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var res= await http.Response.fromStream(response);

        return Response(
            status: true, message: 'تم الإرسال  بنجاح', data: res.body);
      } else {
        return Response(status: false, message: 'فشل الإرسال ', data: null);
      }
    }else{
      return Response(status: false, message: 'فشل الإرسال', data: null);

    }

  }

}
