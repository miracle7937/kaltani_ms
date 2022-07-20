class ItemResponse {
  bool? status;
  List<ItemData>? itemData;

  ItemResponse({this.status, this.itemData});

  ItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      itemData = <ItemData>[];
      json['data'].forEach((v) {
        itemData!.add(ItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (itemData != null) {
      data['item_data'] = itemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemData {
  int? id;
  String? item;
  String? userId;

  ItemData({this.id, this.item, this.userId});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['user_id'] = userId;
    return data;
  }
}
