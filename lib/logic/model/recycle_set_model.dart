import '../../utils/null_checker.dart';

class RecycleSetModel {
  String? itemWeightInput;
  String? itemWeightOutput;

  RecycleSetModel({this.itemWeightInput, this.itemWeightOutput});

  RecycleSetModel.fromJson(Map<String, dynamic> json) {
    itemWeightInput = json['item_weight_input'];
    itemWeightOutput = json['item_weight_output'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['item_weight_input'] = itemWeightInput;
    data['item_weight_output'] = itemWeightOutput;
    return data;
  }

  get isValid => isNotEmpty(itemWeightInput) && isNotEmpty(itemWeightOutput);
}
