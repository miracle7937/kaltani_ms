class UpdateTransferModel {
  String? id;
  String? status;
  String? reason;

  UpdateTransferModel({id, status, reason});

  UpdateTransferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}
