class BailTransferSetModel {
  CleanClear? cleanClear;
  CleanClear? greenColour;
  CleanClear? others;
  CleanClear? trash;
  CleanClear? caps;
  String? factoryId;
  String? itemId;

  BailTransferSetModel(
      {cleanClear, greenColour, others, trash, caps, factoryId, itemId});

  BailTransferSetModel.fromJson(Map json, locationID, materialItemId) {
    print(json['Clean_Clear']);
    // if (json['Clean_Clear'] != null) {}
    // cleanClear = json['Clean_Clear'] != null
    //     ? CleanClear.fromJson(json['Clean_Clear'])
    //     : null;
    // greenColour = json['Green_Colour'] != null
    //     ? CleanClear.fromJson(json['Green_Colour'])
    //     : null;
    // others =
    //     json['Others'] != null ? CleanClear.fromJson(json['Others']) : null;
    // trash = json['Trash'] != null ? CleanClear.fromJson(json['Trash']) : null;
    // caps = json['Caps'] != null ? CleanClear.fromJson(json['Caps']) : null;
    factoryId = locationID;
    itemId = materialItemId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (cleanClear != null) {
      data['Clean_Clear'] = cleanClear!.toJson();
    }
    if (greenColour != null) {
      data['Green_Colour'] = greenColour!.toJson();
    }
    if (others != null) {
      data['Others'] = others!.toJson();
    }
    if (trash != null) {
      data['Trash'] = trash!.toJson();
    }
    if (caps != null) {
      data['Caps'] = caps!.toJson();
    }
    data['factory_id'] = factoryId;
    data['item_id'] = itemId;
    return data;
  }
}

class CleanClear {
  int? totalWeight;
  int? quantity;

  CleanClear({totalWeight, quantity});

  CleanClear.fromJson(Map<String, dynamic> json) {
    totalWeight = json['total_weight'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_weight'] = totalWeight;
    data['quantity'] = quantity;
    return data;
  }
}
