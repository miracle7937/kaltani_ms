class CollectionItemResponse {
  bool? status;
  List<CollectionData>? data;

  CollectionItemResponse({this.status, this.data});

  CollectionItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CollectionData>[];
      json['data'].forEach((v) {
        data!.add(CollectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionData {
  int? id;
  String? item;
  String? itemWeight;
  String? location;
  String? amount;
  String? userId;
  String? createdAt;
  String? updatedAt;

  CollectionData(
      {this.id,
      this.item,
      this.itemWeight,
      this.location,
      this.amount,
      this.userId,
      this.createdAt,
      this.updatedAt});

  CollectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    itemWeight = json['item_weight'];
    location = json['location'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['item_weight'] = itemWeight;
    data['location'] = location;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
