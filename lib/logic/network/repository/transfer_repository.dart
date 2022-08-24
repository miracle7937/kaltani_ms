import '../../../utils/api_routes.dart';
import '../../model/generic_response.dart';
import '../../model/transfer_list_model.dart';
import '../http_request.dart';

class TransferRepository {
  static Future<TransferItemResponse> getTransfer() async {
    var response = await ServerData().getData(path: APIRoute.getTransfer);
    return TransferItemResponse.fromJson(response.data);
  }

  static Future<GenericResponse> transferStatus(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.updateTransfer, body: map);
    return GenericResponse.fromJson(response.data);
  }

  static Future<GenericResponse> transfer(
      Map map, bool forBailedTransfer) async {
    var response = await ServerData().postData(
        path: forBailedTransfer ? APIRoute.transfer : APIRoute.transferSorting,
        body: map);
    return GenericResponse.fromJson(response.data);
  }
}
