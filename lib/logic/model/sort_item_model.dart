class SetItem {
  String? sortItem;
  String? sortItemWeight;
  String? itemName;
  SetItem({this.sortItem, this.sortItemWeight, this.itemName});

  SetItem.fromJson(Map<String, dynamic> json) {
    sortItem = json['sort_item'];
    sortItemWeight = json['sort_item_weight'];
    itemName = json['itemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sort_item'] = sortItem;
    data['sort_item_weight'] = sortItemWeight;
    data['itemName'] = itemName;
    return data;
  }
}
