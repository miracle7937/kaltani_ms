class CollectionSetData {
  String? item;
  String? itemWeight;
  String? location;
  String? amount;
  String? userId;
  String? pricePerKg;
  String? transport;
  String? others;
  String? loader;
  String? type;

  CollectionSetData(
      {this.item,
      this.itemWeight,
      this.location,
      this.amount,
      this.userId,
      this.pricePerKg,
      this.transport,
      this.others,
      this.loader,
      this.type});

  CollectionSetData.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemWeight = json['item_weight'];
    location = json['location'];
    amount = json['amount'];
    userId = json['userId'];
    pricePerKg = json['price_per_kg'];
    transport = json["transport"];
    others = json["others"];
    loader = json["loader"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['item_weight'] = itemWeight;
    data['location'] = location;
    data['amount'] = amount;
    data['userId'] = userId;
    data['price_per_kg'] = pricePerKg;
    data['transport'] = transport;
    data['others'] = others;
    data['loader'] = loader;
    data['type'] = type;
    return data;
  }
}
