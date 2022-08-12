import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../../model/auth_response_model.dart';
import '../../model/auth_set_model.dart';
import '../../model/change_password_set_model.dart';
import '../http_request.dart';

class AuthRepository {
  static Future<AuthResponse> login(AuthSetModel authSetModel) async {
    var response = await ServerData()
        .postData(path: APIRoute.login, body: authSetModel.toJson());
    return AuthResponse.fromJson(response.data);
  }

  static Future<GenericResponse> changePassword(
      ChangePasswordModel changePasswordModel) async {
    var response = await ServerData().postData(
        path: APIRoute.updatePassword, body: changePasswordModel.toJson());
    return GenericResponse.fromJson(response.data);
  }
}
