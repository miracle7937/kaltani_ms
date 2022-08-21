import 'package:kaltani_ms/utils/null_checker.dart';

class SaleSetModel {
  String? itemWeight;
  String? amount;
  String? currency;
  String? freight;
  String? pricePerTon;
  String? customerName;

  SaleSetModel({this.itemWeight, this.amount});

  SaleSetModel.fromJson(Map<String, dynamic> json) {
    itemWeight = json['item_weight'];
    amount = json['amount'];
    currency = json['currency'];
    freight = json['freight'];
    pricePerTon = json['price_per_tone'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_weight'] = itemWeight;
    data['currency'] = currency;
    data['freight'] = freight;
    data['price_per_tone'] = pricePerTon;
    data['amount'] = amount;
    data['customer_name'] = customerName;
    return data;
  }

  get isValid =>
      isNotEmpty(itemWeight) &&
      isNotEmpty(currency) &&
      isNotEmpty(freight) &&
      isNotEmpty(customerName) &&
      isNotEmpty(pricePerTon);
}
