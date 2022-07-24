class TransferItemResponse {
  bool? status;
  String? bailed;
  BailedBreakdown? bailedBreakdown;
  List<Factory>? factory;
  List<Items>? items;
  List<TransferItem>? transferItem;
  List<TransferHistory>? transferHistory;

  TransferItemResponse(
      {status,
      bailed,
      bailedBreakdown,
      factory,
      items,
      transferItem,
      transferHistory});

  TransferItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bailed = json['bailed'];
    bailedBreakdown = json['bailed_breakdown'] != null
        ? BailedBreakdown.fromJson(json['bailed_breakdown'])
        : null;
    if (json['factory'] != null) {
      factory = <Factory>[];
      json['factory'].forEach((v) {
        factory!.add(Factory.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['transfer_item'] != null) {
      transferItem = <TransferItem>[];
      json['transfer_item'].forEach((v) {
        transferItem!.add(TransferItem.fromJson(v));
      });
    }
    if (json['transfer_history'] != null) {
      transferHistory = <TransferHistory>[];
      json['transfer_history'].forEach((v) {
        transferHistory!.add(TransferHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['bailed'] = bailed;
    if (bailedBreakdown != null) {
      data['bailed_breakdown'] = bailedBreakdown!.toJson();
    }
    if (factory != null) {
      data['factory'] = factory!.map((v) => v.toJson()).toList();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (transferItem != null) {
      data['transfer_item'] = transferItem!.map((v) => v.toJson()).toList();
    }
    if (transferHistory != null) {
      data['transfer_history'] =
          transferHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BailedBreakdown {
  int? id;
  Null? blueColour;
  String? greenColour;
  String? cleanClear;
  String? locationId;
  String? createdAt;
  String? updatedAt;

  BailedBreakdown(
      {id,
      blueColour,
      greenColour,
      cleanClear,
      locationId,
      createdAt,
      updatedAt});

  BailedBreakdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blueColour = json['Blue_Colour'];
    greenColour = json['Green_Colour'];
    cleanClear = json['Clean_Clear'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['Blue_Colour'] = blueColour;
    data['Green_Colour'] = greenColour;
    data['Clean_Clear'] = cleanClear;
    data['location_id'] = locationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Factory {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Factory({id, name, address, city, state, userId, createdAt, updatedAt});

  Factory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

class TransferItem {
  int? id;
  String? item;
  String? itemsId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  TransferItem({id, item, itemsId, userId, createdAt, updatedAt});

  TransferItem.fromJson(Map<String, dynamic> json) {
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

class TransferHistory {
  int? id;
  String? collectionId;
  String? factoryId;
  String? transferItem;
  String? itemWeight;
  String? locationId;
  String? status;
  Null? rejReason;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Factory? factory;
  Factory? location;

  TransferHistory(
      {id,
      collectionId,
      factoryId,
      transferItem,
      itemWeight,
      locationId,
      status,
      rejReason,
      userId,
      createdAt,
      updatedAt,
      factory,
      location});

  TransferHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collection_id'];
    factoryId = json['factory_id'];
    transferItem = json['transfer_item'];
    itemWeight = json['item_weight'];
    locationId = json['location_id'];
    status = json['status'];
    rejReason = json['rej_reason'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    factory =
        json['factory'] != null ? Factory.fromJson(json['factory']) : null;
    location =
        json['location'] != null ? Factory.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['collection_id'] = collectionId;
    data['factory_id'] = factoryId;
    data['transfer_item'] = transferItem;
    data['item_weight'] = itemWeight;
    data['location_id'] = locationId;
    data['status'] = status;
    data['rej_reason'] = rejReason;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (factory != null) {
      data['factory'] = factory!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}
