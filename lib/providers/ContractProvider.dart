import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/Contract.dart';
import '../model/Response.dart';
import '../services/api_request.dart';

class ContractProvider extends ChangeNotifier {
  List<Contract>? contracts;

  Future getContract() async {
    final ApiRequest _apiRequest = ApiRequest();
    Response result = await _apiRequest.postWithToken(apiGetContract, {});
    if (result.status == true) {
      contracts=[];
      List data = jsonDecode(result.data!);
      for (var element in data) {
        contracts!.add(Contract.fromJson(element));
      }
      contracts = contracts!.reversed.toList();
    }else{
      contracts =[];
    }
    notifyListeners();
  }

  Future<String> sendConfirmPay(String imagePath, int contractID) async {
    final ApiRequest _apiRequest = ApiRequest();
    Map<String, String> body = {};
    body['contract_id'] = contractID.toString();
    Response result = await _apiRequest.sendConfirmPay(body, imagePath);
    if (result.status == true) {
      try {
        var data = jsonDecode(result.data!);
        String linkConfirmPay = data['data']['link_confirm_pay'];

        contracts!
            .firstWhere((element) => element.id == contractID)
            .linkConfirmPay = linkConfirmPay;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
    return result.message!;
  }
}
