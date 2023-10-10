class AdCampaign {
  int? id;
  String? state;
  String? picture;
  String? startDate;
  String? endDate;
  String? priceType;

  AdCampaign(
      {this.id,
      this.state,
      this.startDate,
      this.endDate,
      this.picture,
      this.priceType});

  AdCampaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'] == 2
        ? 'قيد الانتظار'
        : (json['state'] == 1 ? 'قبول' : 'رفض');
    startDate = json['start_date'];
    endDate = json['end_date'];
    picture = json['picture'];
    priceType = json['price_type'] == 1 ? 'دفع نقدي' : 'دفع الكتروني';
  }
}
