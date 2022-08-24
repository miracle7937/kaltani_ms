class KeyValueModel {
  String? key;
  String? value;

  KeyValueModel({this.key, this.value});

  KeyValueModel.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = key;
    data['Value'] = value;
    return data;
  }
}
