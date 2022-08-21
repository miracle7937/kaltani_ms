import 'package:kaltani_ms/logic/model/auth_response_model.dart';

class AllLocations {
  bool? status;
  String? message;
  List<Location>? data;

  AllLocations({status, message, data});

  AllLocations.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Location>[];
      json['data'].forEach((v) {
        data!.add(Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data2 = <String, dynamic>{};
    data2['status'] = status;
    data2['message'] = message;
    if (data != null) {
      data2['data'] = data!.map((v) => v.toJson()).toList();
    }
    return data2;
  }
}
