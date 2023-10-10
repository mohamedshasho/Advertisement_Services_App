import 'Billboard.dart';
import 'Media.dart';

class DataAds {
  List<Medias>? medias;
  List<Billboard>? billboards;
  List<String>? specialties;

  DataAds({this.medias, this.billboards, this.specialties});

  DataAds.fromJson(Map<String, dynamic> json) {
    if (json['medias'] != null) {
      medias = [];
      json['medias'].forEach((v) {
        medias!.add(Medias.fromJson(v));
      });
    }
    if (json['billboards'] != null) {
      billboards = [];
      json['billboards'].forEach((v) {
        billboards!.add(Billboard.fromJson(v));
      });
    }
    if (json['specialties'] != null) {
      specialties = [];
      json['specialties'].forEach((v) {
        specialties!.add(v['specialty']);
      });
    }
  }
}
