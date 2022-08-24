class MaterialItems {
  String? itemId;
  String? cleanClear;
  String? greenColour;
  String? others;
  String? trash;

  MaterialItems({itemId, cleanClear, greenColour, others, trash});

  MaterialItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    cleanClear = json['Clean_Clear'];
    greenColour = json['Green_Colour'];
    others = json['Others'];
    trash = json['Trash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['Clean_Clear'] = cleanClear;
    data['Green_Colour'] = greenColour;
    data['Others'] = others;
    data['Trash'] = trash;
    return data;
  }
}
