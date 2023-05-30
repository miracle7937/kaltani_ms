import '../../../utils/api_routes.dart';
import '../../controller/transfer_controller.dart';
import '../../model/generic_response.dart';
import '../../model/transfer_list_model.dart';
import '../http_request.dart';

class TransferRepository {
  static Future<TransferItemResponse> getTransfer() async {
    var response = await ServerData().getData(path: APIRoute.getTransfer);
    return TransferItemResponse.fromJson(response.data);
  }

  static Future<TransferHistory> getHistory() async {
    var response = await ServerData().getData(path: APIRoute.getHistory);
    return TransferHistory.fromJson(response.data);
  }

  static Future<GenericResponse> transferStatus(Map map) async {
    var response =
        await ServerData().postData(path: APIRoute.updateTransfer, body: map);
    return GenericResponse.fromJson(response.data);
  }

  static Future<GenericResponse> transferUnsorted(
      Map map, TransferType? transferType) async {
    var response = await ServerData().postData(
        path: transferType == TransferType.bailed
            ? APIRoute.transferUnsortedBailed
            : APIRoute.transferUnsortedLoose,
        body: map);
    return GenericResponse.fromJson(response.data);
  }

  static Future<GenericResponse> transfer(
      Map map, TransferType? transferType) async {
    var response = await ServerData().postData(
        path: transferType == TransferType.bailed
            ? APIRoute.transferSortedBailed
            : APIRoute.transferSortedLoose,
        body: map);
    return GenericResponse.fromJson(response.data);
  }
}
