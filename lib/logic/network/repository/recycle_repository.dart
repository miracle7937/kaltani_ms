import '../../../utils/api_routes.dart';
import '../../model/generic_response.dart';
import '../http_request.dart';

class RecycleRepository {
  static Future<GenericResponse> recycle(Map map) async {
    var response = await ServerData().postData(path: APIRoute.sales, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
