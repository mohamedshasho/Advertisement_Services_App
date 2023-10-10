class Billboard {
  int? id;
  String? siteType;
  String? regionName;
  String? siteName;
  int? measurementsWidth;
  int? measurementsHeight;
  String? measurementsName;
  int? discount;
  String? discountStartDate;
  String? discountEndDate;
  String? discountType;
  double? price;
  String? picture;
  bool? isActive;

  Billboard(
      {this.id,
      this.siteType,
      this.regionName,
      this.siteName,
      this.measurementsWidth,
      this.measurementsHeight,
      this.measurementsName,
      this.discount,
      this.discountStartDate,
      this.discountEndDate,
      this.discountType,
      this.price,
      this.picture,
      this.isActive});

  Billboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteType = json['site_type'];
    regionName = json['region_name'];
    siteName = json['site_name'];
    measurementsWidth = json['measurements_width'];
    measurementsHeight = json['measurements_height'];
    measurementsName = json['measurements_name'];
    discount = json['discount'];
    discountStartDate = json['discount_start_date'];
    discountEndDate = json['discount_end_date'];
    discountType = json['discount_type'];
    price = double.tryParse(json['price'].toString());
    picture = json['picture'];
    isActive = json['is_active'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['site_type'] = siteType;
    data['region_name'] = regionName;
    data['site_name'] = siteName;
    data['measurements_width'] = measurementsWidth;
    data['measurements_height'] = measurementsHeight;
    data['measurements_name'] = measurementsName;
    data['discount'] = discount;
    data['discount_start_date'] = discountStartDate;
    data['discount_end_date'] = discountEndDate;
    data['discount_type'] = discountType;
    data['price'] = price;
    data['picture'] = picture;
    data['is_active'] = isActive;
    return data;
  }
}
