import 'package:kaltani_ms/utils/null_checker.dart';

class SaleSetModel {
  String? itemWeight;
  String? amount;

  SaleSetModel({this.itemWeight, this.amount});

  SaleSetModel.fromJson(Map<String, dynamic> json) {
    itemWeight = json['item_weight'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_weight'] = itemWeight;
    data['amount'] = amount;
    return data;
  }

  get isValid => isNotEmpty(itemWeight) && isNotEmpty(amount);
}
