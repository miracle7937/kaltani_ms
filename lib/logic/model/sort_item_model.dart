class SortedItem {
  String? sortItem;
  String? sortItemWeight;
  String? itemName;
  SortedItem({this.sortItem, this.sortItemWeight, this.itemName});

  SortedItem.fromJson(Map<String, dynamic> json) {
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
