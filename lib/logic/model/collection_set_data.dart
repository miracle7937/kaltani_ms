class CollectionSetData {
  String? item;
  String? itemWeight;
  String? location;
  String? amount;
  String? userId;

  CollectionSetData(
      {this.item, this.itemWeight, this.location, this.amount, this.userId});

  CollectionSetData.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemWeight = json['item_weight'];
    location = json['location'];
    amount = json['amount'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['item_weight'] = itemWeight;
    data['location'] = location;
    data['amount'] = amount;
    data['userId'] = userId;
    return data;
  }
}
