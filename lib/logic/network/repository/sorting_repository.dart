import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../../model/item_response.dart';
import '../http_request.dart';

class SortingRepository {
  static Future<ItemResponse> getItem() async {
    var response = await ServerData().getData(path: APIRoute.itemList);
    return ItemResponse.fromJson(response.data);
  }

  static Future<GenericResponse> sortItem(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.itemList, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
