import '../../../utils/api_routes.dart';
import '../../model/auth_response_model.dart';
import '../../model/auth_set_model.dart';
import '../http_request.dart';

class AuthRepository {
  static Future<AuthResponse> login(AuthSetModel authSetModel) async {
    var response = await ServerData()
        .postData(path: APIRoute.login, body: authSetModel.toJson());
    return AuthResponse.fromJson(response.data);
  }
}
