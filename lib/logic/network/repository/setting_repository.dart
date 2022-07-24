import '../../../utils/api_routes.dart';
import '../../model/generic_response.dart';
import '../http_request.dart';

class SettingRepository {
  static Future<GenericResponse> sortItem(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.deviceId, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
