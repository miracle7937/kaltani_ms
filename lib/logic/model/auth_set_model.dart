import 'package:kaltani_ms/utils/null_checker.dart';

class AuthSetModel {
  String? password;
  String? email;

  AuthSetModel({this.password, this.email});

  AuthSetModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['email'] = email;
    return data;
  }

  bool isValid() => isNotEmpty(email) && isNotEmpty(password);
}
