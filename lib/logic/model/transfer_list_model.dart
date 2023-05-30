class TransferItemResponse {
  bool? status;
  String? bailed;
  String? unsortedBailedTotal;
  String? unsortedLooseTotal;
  BailedBreakdown? bailedBreakdown;
  List<SortedBreakdown>? bailedSortedBrakedown;
  List<SortedBreakdown>? looseSortedBrakedown;
  List<FactoryLocation>? locationFactory;
  List<Items>? items;
  List<TransferItem>? transferItem;

  TransferItemResponse(
      {status,
      bailed,
      bailedBreakdowns,
      factory,
      items,
      transferItem,
      transferHistory});

  TransferItemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bailed = json['bailed'];
    unsortedBailedTotal = json['unsorted_bailed_total'];
    unsortedLooseTotal = json['unsorted_loose_total'];
    bailedBreakdown = json['bailed_breakdown'] != null
        ? BailedBreakdown.fromJson(json['bailed_breakdown'])
        : null;

    if (json['bailed_sorted_brakedown'] != null) {
      bailedSortedBrakedown = <SortedBreakdown>[];
      json['bailed_sorted_brakedown'].forEach((v) {
        bailedSortedBrakedown!.add(SortedBreakdown.fromJson(v));
      });
    }

    if (json['loose_sorted_brakedown'] != null) {
      looseSortedBrakedown = <SortedBreakdown>[];
      json['loose_sorted_brakedown'].forEach((v) {
        looseSortedBrakedown!.add(SortedBreakdown.fromJson(v));
      });
    }
    if (json['location'] != null) {
      locationFactory = <FactoryLocation>[];
      json['location'].forEach((v) {
        locationFactory!.add(FactoryLocation.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['bailed'] = bailed;
    data['unsorted_bailed_total'] = unsortedBailedTotal;
    data['unsorted_loose_total'] = unsortedLooseTotal;
    if (bailedBreakdown != null) {
      data['bailed_breakdown'] = bailedBreakdown!.toJson();
    }
    if (bailedSortedBrakedown != null) {
      data['bailed_sorted_brakedown'] =
          bailedSortedBrakedown!.map((v) => v.toJson()).toList();
    }

    if (looseSortedBrakedown != null) {
      data['loose_sorted_brakedown'] =
          looseSortedBrakedown!.map((v) => v.toJson()).toList();
    }
    if (locationFactory != null) {
      data['location'] = locationFactory!.map((v) => v.toJson()).toList();
    }

    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (transferItem != null) {
      data['transfer_item'] = transferItem!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class SortedBreakdown {
  String? value;
  String? key;

  SortedBreakdown({this.value, this.key});

  SortedBreakdown.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['key'] = this.key;
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

class FactoryLocation {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? userId;
  String? createdAt;
  String? updatedAt;

  FactoryLocation(
      {id, name, address, city, state, userId, createdAt, updatedAt});

  FactoryLocation.fromJson(Map<String, dynamic> json) {
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

  TransferItem({id, item, itemsId, userId, createdAt, updatedAt});

  TransferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    itemsId = json['items_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['items_id'] = itemsId;
    data['user_id'] = userId;

    return data;
  }
}

class TransferHistory {
  bool? status;
  List<History>? history;

  TransferHistory({this.status, this.history});

  TransferHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? staffName;
  String? address;
  String? fromLocation;
  String? toLocation;
  String? rejReason;
  String? userId;
  dynamic status;
  TransferHistoryData? data;
  String? createdAt;
  int? id;

  History(
      {this.fromLocation,
      this.toLocation,
      this.rejReason,
      this.userId,
      this.status,
      this.data});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    rejReason = json['rej_reason'];
    userId = json['user_id'];
    status = json['status'];
    staffName = json['staff_name'];
    address = json['address'];
    data = json['data'] != null
        ? TransferHistoryData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['rej_reason'] = this.rejReason;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['address'] = this.address;
    data['staff_name'] = this.staffName;
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TransferHistoryData {
  String? caps;
  String? others;
  String? trash;
  String? greenColour;
  String? cleanClear;
  String? hdpe;
  String? ldpe;
  String? brown;
  String? black;

  TransferHistoryData(
      {this.caps,
      this.others,
      this.trash,
      this.greenColour,
      this.cleanClear,
      this.hdpe,
      this.ldpe,
      this.brown,
      this.black});

  TransferHistoryData.fromJson(Map<String, dynamic> json) {
    caps = json['Caps'];
    others = json['Others'];
    trash = json['Trash'];
    greenColour = json['Green_Colour'];
    cleanClear = json['Clean_Clear'];
    hdpe = json['hdpe'];
    ldpe = json['ldpe'];
    brown = json['brown'];
    black = json['black'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Caps'] = this.caps;
    data['Others'] = this.others;
    data['Trash'] = this.trash;
    data['Green_Colour'] = this.greenColour;
    data['Clean_Clear'] = this.cleanClear;
    data['hdpe'] = this.hdpe;
    data['ldpe'] = this.ldpe;
    data['brown'] = this.brown;
    data['black'] = this.black;
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
