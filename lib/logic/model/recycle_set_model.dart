import '../../utils/null_checker.dart';

class RecycleSetModel {
  String? itemWeightInput;
  String? itemWeightOutput;
  String? causticSoda;
  String? detergent;

  RecycleSetModel({this.itemWeightInput, this.itemWeightOutput});

  RecycleSetModel.fromJson(Map<String, dynamic> json) {
    itemWeightInput = json['item_weight_input'];
    itemWeightOutput = json['item_weight_output'];
    causticSoda = json['costic_soda'];
    detergent = json['detergent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_weight_input'] = itemWeightInput;
    data['item_weight_output'] = itemWeightOutput;
    data['costic_soda'] = causticSoda;
    data['detergent'] = detergent;
    return data;
  }

  get isValid => isNotEmpty(itemWeightInput) && isNotEmpty(itemWeightOutput);
}
