import 'package:kaltani_ms/logic/local_storage.dart';

import '../utils/role_enum.dart';

class Role {
  static Future<bool> get(List<RolesEnum> roleList) async {
    String? userRole = await getUserRole();
    List<String> stringRoleList =
        roleList.map((role) => role.name.toString().toLowerCase()).toList();

    var userRoleString = userRole.toString().replaceAll(" ", "").toLowerCase();
    return stringRoleList.contains(userRoleString);
  }

  // static Future<bool> canPostInTransferView() async {
  //   String? userRole = await getUserRole();
  //   var userRoleString = userRole.toString().replaceAll(" ", "").toLowerCase();
  //   return stringRoleList.contains(userRoleString);
  // }
}
