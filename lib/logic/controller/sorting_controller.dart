import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/null_checker.dart';
import '../../utils/scaffolds_widget/page_state.dart';
import '../../utils/string_helper.dart';
import '../model/sorting_item_response.dart';
import '../network/repository/sorting_repository.dart';

class SortingController extends ChangeNotifier {
  List<SortingItems> itemDataList = [];
  SortingItemResponse? sortingItemResponse;
  PageState pageState = PageState.loaded;
  var materialData = {};
  late SortingView _sortingView;
  String? itemID;
  num unsortedWeight = 0;
  int count = 0;
  String errorMessage = "";
  setView(v) {
    _sortingView = v;
  }

  setItemID(v) {
    itemID = v;
  }

  fetItemList(
    BuildContext context,
  ) {
    if (itemDataList.isEmpty && count < 1) {
      pageState = PageState.loading;
      request(context);
      count++;
    }
  }

  refresh(BuildContext context) {
    pageState = PageState.loading;
    notifyListeners();
    request(context);
  }

  request(BuildContext context) {
    SortingRepository.getItem().then((value) {
      if (value.status = true && value.sortingItems != null) {
        // itemDataList.clear();
        itemDataList = value.sortingItems!;
        sortingItemResponse = value;
        pageState = PageState.loaded;
      } else {
        errorMessage = value.message ?? "Could not fetch item list";
        _sortingView.onError(context, errorMessage);
        pageState = PageState.error;
      }

      notifyListeners();
    }).catchError((v) {
      errorMessage = v.toString();
      _sortingView.onError(context, errorMessage);
      pageState = PageState.error;
      notifyListeners();
    });
  }

  submit(BuildContext context, WidgetRef ref) {
    if (materialData.isNotEmpty) {
      if (unsortedWeight < 0) {
        _sortingView.onError(
            context, "unsorted material has exceed total material");
        return;
      }

      materialData["item_id"] = sortingItemResponse?.items?.first.id.toString();
      postSortingCall(context, ref, materialData);
    } else {
      _sortingView.onError(context, "Please add item type");
    }
  }

  postSortingCall(BuildContext context, WidgetRef ref, Map data) {
    pageState = PageState.loading;
    notifyListeners();
    SortingRepository.sortItem(data).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _sortingView.onSuccess(context, value.message!);
      } else {
        _sortingView.onError(context, value.message!);
      }
      _sortingView.onClearUI(ref);
    }).catchError((v) {
      _sortingView.onClearUI(ref);
      _sortingView.onError(context, v.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  bool? haveItemsSelectedSorting(SortingItems itemData, BuildContext context) {
    bool exist = materialData.containsKey(dbStringReplacer(itemData.item));
    if (unsortedWeight < 0) {
      _sortingView.onError(
          context, "unsorted material has exceed total material");
      return true;
    }

    if (exist) {
      _sortingView.onError(
          context, "${itemData.item!} has been selected already");
      return true;
    }
    return false;
  }

  unsorted() {
    num totalSelectedWeight = 0;
    for (var key in materialData.keys) {
      if (isNotEmpty(materialData[key]) && key != "item_id") {
        totalSelectedWeight =
            totalSelectedWeight + num.parse(materialData[key]);
      }
    }
    unsortedWeight =
        num.parse(sortingItemResponse!.totalCollected!) - totalSelectedWeight;
    notifyListeners();
  }

  void clear() {
    materialData.clear();
    unsortedWeight = 0;
  }

  displayMessage(BuildContext context, String message) {
    _sortingView.onError(context, message);
  }
}

abstract class SortingView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onClearUI(WidgetRef ref);
}
