import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/logic/model/key_value_model.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../model/bailing_item_response.dart';
import '../model/sort_item_model.dart';
import '../network/repository/bailing_repository.dart';

class BailingController extends ChangeNotifier {
  PageState pageState = PageState.loaded;
  List<BailingItem> bailingItem = [];
  late BailingView _bailingView;
  BailingItemResponse? bailingItemResponse;

  List<SetItem> item = [];

  addSortedItem() {
    item.add(SetItem());
  }

  removeSortedItem(int i) {
    if (item.isNotEmpty) {
      item.removeAt(i);
    }
  }

  setView(v) {
    _bailingView = v;
  }

  fetItemList(
    BuildContext context,
  ) {
    if (bailingItem.isEmpty) {
      pageState = PageState.loading;
      BailingRepository.getItem().then((value) {
        if (value.status = true && value.bailingItem != null) {
          bailingItem.addAll(value.bailingItem!);
          bailingItemResponse = value;
        } else {
          _bailingView.onError(context, "could not fetch item list");
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((v) {
        _bailingView.onError(context, "could not fetch item list");
        pageState = PageState.loaded;
        notifyListeners();
      });
    }
  }

  submit(BuildContext context) {
    var data = {};
    List<String> itemsWeightList = [];
    List<String> itemListID = [];
    if (item.isNotEmpty) {
      for (var element in item) {
        if (element.sortItem != null && element.sortItemWeight == null) {
          _bailingView.onError(context, "${element.itemName} can not be empty");
        } else if (element.sortItem == null) {
          _bailingView.onError(context, "Field(s) can not be empty");
        } else {
          itemsWeightList.add(element.sortItemWeight!);
          itemListID.add(element.sortItem!);
        }
      }
      data["item_weight"] = itemsWeightList;
      data["sort_item"] = itemListID;
      data["item_id"] = bailingItemResponse?.items?.first.id.toString();

      postSortingCall(context, data);
    } else {
      _bailingView.onError(context, "Please add items");
    }
  }

  postSortingCall(BuildContext context, Map data) {
    pageState = PageState.loading;
    notifyListeners();
    BailingRepository.bailItem(data).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _bailingView.onSuccess(context, value.message!);
      } else {
        _bailingView.onError(context, value.message!);
      }
    }).catchError((v) {
      _bailingView.onServerError(context, v.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  bool? haveItemsSelectedBailing(BailingItem itemData, BuildContext context) {
    bool exist =
        item.map((e) => e.sortItem).toList().contains(itemData.id.toString());
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
      if (breakDownMap.containsKey(key.item?.replaceAll(" ", "_"))) {
        listOfKeyValue.add(KeyValueModel(
            key: key.item,
            value: breakDownMap[key.item?.replaceAll(" ", "_")]));
      }
    });
    return listOfKeyValue;
  }

  void clear() {
    item.clear();
  }
}

abstract class BailingView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onServerError(BuildContext context, String message);
}
