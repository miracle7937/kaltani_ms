import 'package:flutter/cupertino.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../model/item_response.dart';
import '../model/sort_item_model.dart';
import '../network/repository/sorting_repository.dart';

class SortingController extends ChangeNotifier {
  List<ItemData> itemDataList = [];
  PageState pageState = PageState.loaded;
  late SortingView _sortingView;
  List<SortedItem> sortiedItem = [];

  addSortedItem() {
    sortiedItem.add(SortedItem());
  }

  removeSortedItem(int i) {
    if (sortiedItem.isNotEmpty) {
      sortiedItem.removeAt(i);
    }
  }

  setView(v) {
    _sortingView = v;
  }

  fetItemList(
    BuildContext context,
  ) {
    if (itemDataList.isEmpty) {
      pageState = PageState.loading;
      SortingRepository.getItem().then((value) {
        pageState = PageState.loaded;
        notifyListeners();
        if (value.status = true && value.itemData != null) {
          itemDataList.addAll(value.itemData!);
        } else {
          _sortingView.onError(context, "could not fetch item list");
        }
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
          print("hello");
        }
      }
      data["sort_item_weight"] = itemsWeightList;
      data["sort_item"] = itemListID;
      postSortingCall(context, data);
    } else {
      _sortingView.onError(context, "Please add items");
    }

    // data["sort_item_weight"] =
    //     sortiedItem.map((e) => e.sortItemWeight).toList();
    // data["sort_item"] = sortiedItem.map((e) => e.sortItemWeight).toList();
  }

  postSortingCall(BuildContext context, Map data) {
    SortingRepository.sortItem(data).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _sortingView.onSuccess(context, value.message!);
      } else {
        _sortingView.onError(context, value.message!);
      }
    }).catchError((v) {
      _sortingView.onError(context, "could not fetch item list");
      pageState = PageState.loading;
      notifyListeners();
    });
  }

  bool? haveItemsSelected(ItemData itemData, BuildContext context) {
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
}
