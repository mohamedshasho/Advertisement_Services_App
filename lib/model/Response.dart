import 'dart:convert';

import 'package:auth/model/user.dart';

class Response {
  bool? status;
  String? message;
  String? data;

  Response({required this.status, required this.message, required this.data});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? jsonEncode(json['data']) : null;
  }
}
