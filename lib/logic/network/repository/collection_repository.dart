import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../../model/collection_item_response.dart';
import '../../model/collection_set_data.dart';
import '../http_request.dart';

class CollectionRepository {
  static Future<GenericResponse> process(CollectionSetData authSetModel) async {
    var response = await ServerData()
        .postData(path: APIRoute.collection, body: authSetModel.toJson());
    return GenericResponse.fromJson(response.data);
  }

  static Future<CollectionItemResponse> getCollectionItemList() async {
    var response = await ServerData().getData(path: APIRoute.getCollection);
    return CollectionItemResponse.fromJson(response.data);
  }
}
