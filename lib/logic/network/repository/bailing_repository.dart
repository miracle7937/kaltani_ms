import '../../../utils/api_routes.dart';
import '../../model/bailing_item_response.dart';
import '../../model/generic_response.dart';
import '../http_request.dart';

class BailingRepository {
  static Future<BailingItemResponse> getItem() async {
    var response = await ServerData().getData(path: APIRoute.getBailing);
    return BailingItemResponse.fromJson(response.data);
  }

  static Future<GenericResponse> bailItem(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.bailing, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
