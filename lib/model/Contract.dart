
class Contract {

  int? id;
  String? costumer;
  String? contractType;
  String? startDate;
  String? endDate;
  double? price;
  String? priceType;
  String? linkConfirmPay;
  int? discount;
  String? createdAt;

  Contract(
      {this.id,
        this.costumer,
        this.contractType,
        this.startDate,
        this.endDate,
        this.price,
        this.priceType,
        this.discount,
        this.createdAt
      });

  Contract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    costumer = json['full_name'];
    contractType = json['contract_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = double.tryParse(json['price'].toString());
    priceType = json['price_type'] ;
    linkConfirmPay = json['link_confirm_pay'] ;
    discount = json['discount'] ;
    createdAt = json['created_at'] ;
  }
}