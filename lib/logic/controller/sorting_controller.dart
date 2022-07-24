import 'package:flutter/cupertino.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../model/sort_item_model.dart';
import '../model/sorting_item_response.dart';
import '../network/repository/sorting_repository.dart';

class SortingController extends ChangeNotifier {
  List<SortingItems> itemDataList = [];
  SortingItemResponse? sortingItemResponse;
  PageState pageState = PageState.loaded;
  late SortingView _sortingView;
  List<SetItem> sortiedItem = [];
  String? itemID;
  addSortedItem() {
    sortiedItem.add(SetItem());
  }

  removeSortedItem(int i) {
    if (sortiedItem.isNotEmpty) {
      sortiedItem.removeAt(i);
    }
  }

  setView(v) {
    _sortingView = v;
  }

  setItemID(v) {
    itemID = v;
  }

  fetItemList(
    BuildContext context,
  ) {
    if (itemDataList.isEmpty) {
      pageState = PageState.loading;
      SortingRepository.getItem().then((value) {
        if (value.status = true && value.sortingItems != null) {
          itemDataList.addAll(value.sortingItems!);
        } else {
          _sortingView.onError(context, "could not fetch item list");
        }
        sortingItemResponse = value;
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((v) {
        _sortingView.onError(context, "could not fetch item list");
        pageState = PageState.loading;
        notifyListeners();
      });
    }
  }

  submit(BuildContext context) {
    var data = {};
    List<String> itemsWeightList = [];
    List<String> itemListID = [];
    if (sortiedItem.isNotEmpty) {
      for (var element in sortiedItem) {
        if (element.sortItem != null && element.sortItemWeight == null) {
          _sortingView.onError(context, "${element.itemName} can not be empty");
        } else if (element.sortItem == null) {
          _sortingView.onError(context, "Field(s) can not be empty");
        } else {
          itemsWeightList.add(element.sortItemWeight!);
          itemListID.add(element.sortItem!);
        }
      }
      data["sort_item_weight"] = itemsWeightList;
      data["sort_item"] = itemListID;
      data["item_id"] = sortingItemResponse?.items?.first.id.toString();
      postSortingCall(context, data);
    } else {
      _sortingView.onError(context, "Please add items");
    }
  }

  postSortingCall(BuildContext context, Map data) {
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
    }).catchError((v) {
      _sortingView.onServerError(context, v.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  bool? haveItemsSelectedSorting(SortingItems itemData, BuildContext context) {
    bool exist = sortiedItem
        .map((e) => e.sortItem)
        .toList()
        .contains(itemData.id.toString());
    if (exist) {
      _sortingView.onError(
          context, "${itemData.item!} has been selected already");
      return true;
    }
    return false;
  }

  void clear() {
    sortiedItem.clear();
  }
}

abstract class SortingView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onServerError(BuildContext context, String message);
}
