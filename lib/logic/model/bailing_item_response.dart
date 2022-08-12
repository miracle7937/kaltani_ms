class BailingItemResponse {
  bool? status;
  String? message;
  List<Items>? items;
  SortedBreakdown? sortedBreakdown;
  List<BailingItem>? bailingItem;
  String? totalSorted;

  BailingItemResponse(
      {status, message, items, sortedBreakdown, bailingItem, totalSorted});

  BailingItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    sortedBreakdown = json['sorted_breakdown'] != null
        ? SortedBreakdown.fromJson(json['sorted_breakdown'])
        : null;
    if (json['bailing_item'] != null) {
      bailingItem = <BailingItem>[];
      json['bailing_item'].forEach((v) {
        bailingItem!.add(BailingItem.fromJson(v));
      });
    }
    totalSorted = json['total_sorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (sortedBreakdown != null) {
      data['sorted_breakdown'] = sortedBreakdown!.toJson();
    }
    if (bailingItem != null) {
      data['bailing_item'] = bailingItem!.map((v) => v.toJson()).toList();
    }
    data['total_sorted'] = totalSorted;
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

class SortedBreakdown {
  int? id;
  String? others;
  String? trash;
  String? greenColour;
  String? cleanClear;
  String? locationId;
  String? createdAt;
  String? updatedAt;

  SortedBreakdown(
      {id,
      others,
      trash,
      greenColour,
      cleanClear,
      locationId,
      createdAt,
      updatedAt});

  SortedBreakdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    others = json['Others'];
    trash = json['Trash'];
    greenColour = json['Green_Colour'];
    cleanClear = json['Clean_Clear'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['Others'] = others;
    data['Trash'] = trash;
    data['Green_Colour'] = greenColour;
    data['Clean_Clear'] = cleanClear;
    data['location_id'] = locationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BailingItem {
  int? id;
  String? item;
  String? itemsId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  BailingItem({id, item, itemsId, userId, createdAt, updatedAt});

  BailingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    itemsId = json['items_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['items_id'] = itemsId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
