import 'package:kaltani_ms/logic/model/all_location_model.dart';
import 'package:kaltani_ms/logic/model/generic_response.dart';

import '../../../utils/api_routes.dart';
import '../../controller/sales_controller.dart';
import '../../model/sales_bailed_breakdown.dart';
import '../http_request.dart';

class SalesRepository {
  static Future<GenericResponse> sales(
      Map map, SalesMaterials salesMaterials) async {
    var response = await ServerData().postData(
        path: salesMaterials == SalesMaterials.flakes
            ? APIRoute.sales
            : APIRoute.saleBailed,
        body: map);
    return GenericResponse.fromJson(response.data);
  }

  static Future<AllLocations> getLocation() async {
    var response = await ServerData().getData(
      path: APIRoute.getLocation,
    );
    return AllLocations.fromJson(response.data);
  }

  static Future<BailedBreakdownResponse> getBailedBreakDown(locationId) async {
    var response = await ServerData().postData(
        path: APIRoute.getBreakDown, body: {"location_id": locationId});
    return BailedBreakdownResponse.fromJson(response.data);
  }
}
