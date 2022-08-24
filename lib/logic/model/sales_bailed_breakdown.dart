class BailedBreakdownResponse {
  bool? status;
  BailedBreakdown? bailedBreakdown;
  List<BailingItems>? bailingItems;

  BailedBreakdownResponse(
      {this.status, this.bailedBreakdown, this.bailingItems});

  BailedBreakdownResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bailedBreakdown = json['bailed_breakdown'] != null
        ? new BailedBreakdown.fromJson(json['bailed_breakdown'])
        : null;
    if (json['bailing_items'] != null) {
      bailingItems = <BailingItems>[];
      json['bailing_items'].forEach((v) {
        bailingItems!.add(new BailingItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bailedBreakdown != null) {
      data['bailed_breakdown'] = this.bailedBreakdown!.toJson();
    }
    if (this.bailingItems != null) {
      data['bailing_items'] =
          this.bailingItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BailedBreakdown {
  int? id;
  String? caps;
  String? others;
  String? trash;
  String? greenColour;
  String? cleanClear;
  String? locationId;
  String? createdAt;
  String? updatedAt;

  BailedBreakdown(
      {this.id,
      this.caps,
      this.others,
      this.trash,
      this.greenColour,
      this.cleanClear,
      this.locationId,
      this.createdAt,
      this.updatedAt});

  BailedBreakdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caps = json['Caps'];
    others = json['Others'];
    trash = json['Trash'];
    greenColour = json['Green_Colour'];
    cleanClear = json['Clean_Clear'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Caps'] = this.caps;
    data['Others'] = this.others;
    data['Trash'] = this.trash;
    data['Green_Colour'] = this.greenColour;
    data['Clean_Clear'] = this.cleanClear;
    data['location_id'] = this.locationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BailingItems {
  int? id;
  String? item;
  String? itemsId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  BailingItems(
      {this.id,
      this.item,
      this.itemsId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  BailingItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    itemsId = json['items_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['items_id'] = this.itemsId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
