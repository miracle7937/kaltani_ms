import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../http_request.dart';

class SalesRepository {
  static Future<GenericResponse> sales(Map map) async {
    var response = await ServerData().postData(path: APIRoute.sales, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
