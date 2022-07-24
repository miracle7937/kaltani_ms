import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../../model/sorting_item_response.dart';
import '../http_request.dart';

class SortingRepository {
  static Future<SortingItemResponse> getItem() async {
    var response = await ServerData().getData(path: APIRoute.getSorting);
    return SortingItemResponse.fromJson(response.data);
  }

  static Future<GenericResponse> sortItem(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.sorting, body: map);
    return GenericResponse.fromJson(response.data);
  }
}
