import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/controller/auth_controller.dart';

import '../../ui_layer/ui_logic/sorting_page_logic.dart';
import '../controller/collection_controller.dart';
import '../controller/recyle_controller.dart';
import '../controller/sales_controller.dart';
import '../controller/sorting_controller.dart';

final authManager = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});
final collectionManager = ChangeNotifierProvider<CollectionController>((ref) {
  return CollectionController();
});
final sortingManager = ChangeNotifierProvider<SortingController>((ref) {
  return SortingController();
});
final sortingPageLogicManager = ChangeNotifierProvider<SortingPageLogic>((ref) {
  return SortingPageLogic();
});
final salesManager = ChangeNotifierProvider<SalesController>((ref) {
  return SalesController();
});
final recycleManager = ChangeNotifierProvider<RecycleController>((ref) {
  return RecycleController();
});
