import 'dart:convert';

import 'package:auth/model/AdCampaign.dart';
import 'package:auth/model/Response.dart';
import 'package:auth/services/api_request.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class AdsCampaignProvider extends ChangeNotifier {
  List<AdCampaign>? adCampaigns;

  Future getAdsCampaign() async {
    String? authToken = await getStringPreferences("accessToken");
    if (authToken == null) {
      return false;
    }
    String? idCustomer = await getStringPreferences('id_customer');
    Map<String, String> body = {};
    body['api_password'] = apiPassword;
    body['id_customer'] = idCustomer!;

    final ApiRequest _apiRequest = ApiRequest();
    Response result = await _apiRequest.postWithToken(apiGetAdsCampaign, body);
    if (result.status == true) {
      adCampaigns=[];
      List data = jsonDecode(result.data!);
      for (var element in data) {
        adCampaigns!.add(AdCampaign.fromJson(element));
      }
      adCampaigns = adCampaigns!.reversed.toList();
    }else{
      adCampaigns=[];
    }
    notifyListeners();
  }
}
