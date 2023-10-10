class SelectBillboard {
  int id;
  int num;
  SelectBillboard(this.id, [this.num = 1]);

  Map<String, dynamic> toJson() => {'id': id, 'num': num};
}
