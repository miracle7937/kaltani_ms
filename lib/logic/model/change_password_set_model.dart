import '../../utils/null_checker.dart';

class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordModel({oldPassword, newPassword, confirmPassword});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }

  bool isValid() =>
      isNotEmpty(confirmPassword) &&
      isNotEmpty(newPassword) &&
      isNotEmpty(oldPassword);
}
