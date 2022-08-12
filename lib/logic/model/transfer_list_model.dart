class TransferItemResponse {
  bool? status;
  String? bailed;
  BailedBreakdown? bailedBreakdown;
  SortedBreakdown? sortedBreakdown;
  List<Factory>? factory;
  List<CollectionCenter>? collectionCenter;
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
    sortedBreakdown = json['sorted_breakdown'] != null
        ? SortedBreakdown.fromJson(json['sorted_breakdown'])
        : null;
    if (json['factory'] != null) {
      factory = <Factory>[];
      json['factory'].forEach((v) {
        factory!.add(Factory.fromJson(v));
      });
    }
    if (json['collection_center'] != null) {
      collectionCenter = <CollectionCenter>[];
      json['collection_center'].forEach((v) {
        collectionCenter!.add(CollectionCenter.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['bailed'] = bailed;
    if (bailedBreakdown != null) {
      data['bailed_breakdown'] = bailedBreakdown!.toJson();
    }
    if (sortedBreakdown != null) {
      data['sorted_breakdown'] = sortedBreakdown!.toJson();
    }
    if (factory != null) {
      data['factory'] = factory!.map((v) => v.toJson()).toList();
    }
    if (collectionCenter != null) {
      data['collection_center'] =
          collectionCenter!.map((v) => v.toJson()).toList();
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

class SortedBreakdown {
  int? id;
  String? others;
  String? trash;
  String? caps;
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
    caps = json['Caps'];
    cleanClear = json['Clean_Clear'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Others'] = others;
    data['Trash'] = trash;
    data['Green_Colour'] = greenColour;
    data['Clean_Clear'] = cleanClear;
    data['Caps'] = caps;
    data['location_id'] = locationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BailedBreakdown {
  int? id;
  String? others;
  String? trash;
  String? greenColour;
  String? cleanClear;
  String? locationId;
  String? caps;
  String? createdAt;
  String? updatedAt;

  BailedBreakdown(
      {id,
      others,
      trash,
      greenColour,
      cleanClear,
      locationId,
      createdAt,
      updatedAt});

  BailedBreakdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    others = json['Others'];
    trash = json['Trash'];
    greenColour = json['Green_Colour'];
    cleanClear = json['Clean_Clear'];
    caps = json['Caps'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Others'] = others;
    data['Trash'] = trash;
    data['Green_Colour'] = greenColour;
    data['Clean_Clear'] = cleanClear;
    data['Caps'] = caps;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class CollectionCenter {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? userId;
  String? createdAt;
  String? updatedAt;

  CollectionCenter(
      {id, name, address, city, state, userId, createdAt, updatedAt});

  CollectionCenter.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class TransferHistory {
  int? id;
  String? cleanClear;
  String? greenColour;
  String? others;
  String? trash;
  String? collectionId;
  String? factoryId;
  String? locationId;
  String? status;
  String? rejReason;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Factory? factory;
  Factory? location;
  User? user;

  TransferHistory(
      {id,
      cleanClear,
      greenColour,
      others,
      trash,
      collectionId,
      factoryId,
      locationId,
      status,
      rejReason,
      userId,
      createdAt,
      updatedAt,
      factory,
      location,
      user});

  TransferHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cleanClear = json['Clean_Clear'];
    greenColour = json['Green_Colour'];
    others = json['Others'];
    trash = json['Trash'];
    collectionId = json['collection_id'];
    factoryId = json['factory_id'];
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['Clean_Clear'] = cleanClear;
    data['Green_Colour'] = greenColour;
    data['Others'] = others;
    data['Trash'] = trash;
    data['collection_id'] = collectionId;
    data['factory_id'] = factoryId;
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? locationId;
  String? roleId;
  String? factoryId;
  String? deviceId;
  String? createdAt;
  String? updatedAt;

  User(
      {id,
      firstName,
      lastName,
      phone,
      email,
      locationId,
      emailVerifiedAt,
      roleId,
      factoryId,
      deviceId,
      createdAt,
      updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    locationId = json['location_id'];
    roleId = json['role_id'];
    factoryId = json['factory_id'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['location_id'] = locationId;
    data['role_id'] = roleId;
    data['factory_id'] = factoryId;
    data['device_id'] = deviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
