import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/key_value_model.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../../utils/string_helper.dart';
import '../model/bailing_item_response.dart';
import '../network/repository/bailing_repository.dart';

class BailingController extends ChangeNotifier {
  PageState pageState = PageState.loaded;
  List<BailingItem> bailingItem = [];
  late BailingView _bailingView;
  var materialData = {};
  BailingItemResponse? bailingItemResponse;
  int count = 0;
  String errorMessage = "";
  setView(v) {
    _bailingView = v;
  }

  fetItemList(
    BuildContext context,
  ) {
    if (bailingItem.isEmpty && count < 1) {
      pageState = PageState.loading;
      request(context);
      count++;
    }
  }

  request(BuildContext context) {
    BailingRepository.getItem().then((value) {
      if (value.status = true && value.bailingItem != null) {
        bailingItem.clear();
        bailingItem.addAll(value.bailingItem!);
        bailingItemResponse = value;
        pageState = PageState.loaded;
      } else {
        errorMessage = value.message ?? "Could not fetch item list";
        _bailingView.onError(context, errorMessage);
        pageState = PageState.error;
      }
      notifyListeners();
    }).catchError((v) {
      errorMessage = v.toString();
      _bailingView.onError(context, errorMessage);
      pageState = PageState.error;
      notifyListeners();
    });
  }

  refresh(BuildContext context) {
    pageState = PageState.loading;
    notifyListeners();
    request(context);
  }

  submit(BuildContext context, WidgetRef ref) {
    if (materialData.isNotEmpty) {
      materialData["item_id"] = bailingItemResponse?.items?.first.id.toString();

      postSortingCall(context, ref, materialData);
    } else {
      _bailingView.onError(context, "Please add items");
    }
  }

  postSortingCall(BuildContext context, WidgetRef ref, Map data) {
    pageState = PageState.loading;
    notifyListeners();
    BailingRepository.bailItem(data).then((value) {
      print(value.toJson());
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _bailingView.onSuccess(context, value.message!);
      } else {
        _bailingView.onError(context, value.message!);
      }
      _bailingView.onClearUI(context, ref);
    }).catchError((v) {
      _bailingView.onError(context, v.toString());
      _bailingView.onClearUI(context, ref);

      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  bool? haveItemsSelectedBailing(BailingItem itemData, BuildContext context) {
    bool exist = materialData.containsKey(dbStringReplacer(itemData.item));
    if (exist) {
      _bailingView.onError(
          context, "${itemData.item!} has been selected already");
      return true;
    }
    return false;
  }

  List<KeyValueModel> get getAvailableSortedMaterial {
    List<KeyValueModel> listOfKeyValue = [];
    Map breakDownMap = bailingItemResponse!.sortedBreakdown!.toJson();
    bailingItemResponse!.bailingItem?.forEach((key) {
      var amountValue = breakDownMap[key.item?.replaceAll(" ", "_")];
      if (breakDownMap.containsKey(key.item?.replaceAll(" ", "_")) &&
          amountValue != "0") {
        listOfKeyValue.add(KeyValueModel(key: key.item, value: amountValue));
      }
    });
    return listOfKeyValue;
  }

  void clear() {
    materialData.clear();
  }

  displayMessage(BuildContext context, String message) {
    _bailingView.onError(context, message);
  }
}

abstract class BailingView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onClearUI(BuildContext context, WidgetRef ref);
}
