import 'dart:ffi';

class Medias {
  int? id;
  String? socialMediaType;
  String? mediaName;
  String? mediaDescription;
  String? picture;
  double? price;
  int? numFollowing;
  bool? isOnline;

  Medias(
      {this.id,
      this.socialMediaType,
      this.mediaName,
      this.mediaDescription,
      this.picture,
      this.price,
      this.numFollowing,
      this.isOnline});

  Medias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialMediaType = json['social_media_type'];
    mediaName = json['media_name'];
    mediaDescription = json['media_description'];
    picture = json['picture'];
    price = double.tryParse(json['price'].toString());
    numFollowing = json['num_following'];
    isOnline = json['is_online'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['social_media_type'] = socialMediaType;
    data['media_name'] = mediaName;
    data['media_description'] = mediaDescription;
    data['picture'] = picture;
    data['price'] = price;
    data['num_following'] = numFollowing;
    data['is_online'] = isOnline;
    return data;
  }
}
