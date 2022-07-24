import '../../../utils/api_routes.dart';
import '../../model/transfer_list_model.dart';
import '../http_request.dart';

class TransferRepository {
  static Future<TransferItemResponse> getTransfer() async {
    var response = await ServerData().getData(path: APIRoute.getTransfer);
    return TransferItemResponse.fromJson(response.data);
  }

  // static Future<GenericResponse> sortItem(Map map) async {
  //   var response =
  //       await ServerData().postData(path: APIRoute.itemList, body: map);
  //   return GenericResponse.fromJson(response.data);
  // }
}
