import 'dart:convert';
import 'dart:io';
import 'package:auth/constants.dart';
import 'package:auth/model/DataAds.dart';
import 'package:auth/model/Response.dart';
import 'package:auth/model/SelectBillboard.dart';
import 'package:auth/services/api_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

class AdsProvider extends ChangeNotifier {
  DataAds? dataAds;

  String haveDesign = '1';
  File? _design;
  String? _specialty;

  get design => _design;
  get specialty => _specialty;

  int priceType = 1;
  String? _startDate;
  String? _endDate;
  String? _imagePath;
  String? _description;
  int adType = 1;
  List<SelectBillboard> billboardsSelected = [];
  List<int> mediaSelected = [];

  String? adPurpose;
  List<Color> colors = [];


  List<TextEditingController> controllers = [];


  void changeAdType(int type) {
    adType = type;
    notifyListeners();
  }

  void changeDesign(File file) {
    _design = file;
    _setImagePathDesign(file.path);
    notifyListeners();
  }

  void changeHaveDesign(String h) {
    haveDesign = h;
    _design = null;
    notifyListeners();
  }

  Future getData() async {
    final ApiRequest _apiRequest = ApiRequest();
    Response? response = await _apiRequest.post(apiGetData, {});
    if (response!.status!) {
      dataAds = DataAds.fromJson(jsonDecode(response.data!));
      _specialty = dataAds!.specialties![0];
      notifyListeners();
    }
  }

  void changeSpecialty(String s) {
    _specialty = s;
    notifyListeners();
  }

  void changePriceType(int type) {
    priceType = type;
    notifyListeners();
  }

  void setDescription(String v) {
    _description = v;
  }

  Future<Response> addAdsCampaign() async {
    String? idCustomer = await getStringPreferences('id_customer');
    Map<String, String> body = {};
    body['id_customer'] = idCustomer!;
    body['specialty'] = _specialty!;
    body['start_date'] = _startDate!;
    body['end_date'] = _endDate!;
    body['description'] = (_description ?? '');
    body['price_type'] = priceType.toString();
    body['have_design'] = haveDesign;
    body['billboards'] =
        jsonEncode(billboardsSelected.map((e) => e.toJson()).toList());
    body['medias'] = mediaSelected.toString();

    if (haveDesign == '0') {
      body['colors'] =
          colors.map((e) => e.value.toRadixString(16)).toList().toString();
      body['ad_purpose'] = adPurpose!;
    }

    print(body);
    final ApiRequest _apiRequest = ApiRequest();
    Response response = await _apiRequest.addAdsCampaign(body, _imagePath);
    return response;
  }

  void setAdsDetails(String startDate, String endDate) {
    _startDate = startDate;
    _endDate = endDate;
  }

  void _setImagePathDesign(String? imagePath) {
    _imagePath = imagePath;
  }

  SelectBillboard? isBillboardAdded(int id) {
    var found =
        billboardsSelected.firstWhereOrNull((element) => element.id == id);
    return found;
  }

  bool isMediaAdded(int id) {
    var found = mediaSelected.firstWhereOrNull((element) => element == id);
    return found != null;
  }

  void selectBillboard(int id) {
    billboardsSelected.add(SelectBillboard(id));
    notifyListeners();
  }

  void selectMedia(int id) {
    mediaSelected.add(id);
    notifyListeners();
  }

  void cancelMedia(int id) {
    mediaSelected.remove(id);
    notifyListeners();
  }

  void plusBillboard(int id) {
    billboardsSelected.firstWhere((e) => e.id == id).num++;
    // notifyListeners();
  }

  void minusBillboard(int id) {
    SelectBillboard s = billboardsSelected.firstWhere((e) => e.id == id);
    if (s.num > 1) {
      s.num--;
      // notifyListeners();
    }
  }

  void cancelBillboard(int id) {
    billboardsSelected.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addColor(Color color) {
    colors.add(color);
    notifyListeners();
  }

  void clear() {
    _design = null;
    _imagePath = null;
    _description = "";
    adType=1;
    priceType=1;
    adPurpose="";
    mediaSelected.clear();
    billboardsSelected.clear();
    colors.clear();
    controllers.clear();
  }
}
