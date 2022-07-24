class SortingItemResponse {
  bool? status;
  String? message;
  List<Items>? items;
  List<SortingItems>? sortingItems;
  String? totalCollected;

  SortingItemResponse({status, message, items, sortingItems, totalCollected});

  SortingItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['sorting_items'] != null) {
      sortingItems = <SortingItems>[];
      json['sorting_items'].forEach((v) {
        sortingItems!.add(SortingItems.fromJson(v));
      });
    }
    totalCollected = json['total_collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (sortingItems != null) {
      data['sorting_items'] = sortingItems!.map((v) => v.toJson()).toList();
    }
    data['total_collected'] = totalCollected;
    return data;
  }
}

class Items {
  int? id;
  String? item;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Items({id, item, userId, createdAt, updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item'] = item;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SortingItems {
  int? id;
  String? item;
  String? itemsId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  SortingItems({id, item, itemsId, userId, createdAt, updatedAt});

  SortingItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    itemsId = json['items_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item'] = item;
    data['items_id'] = itemsId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
