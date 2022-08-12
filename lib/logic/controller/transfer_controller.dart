import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/null_checker.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../utils/string_helper.dart';
import '../model/key_value_model.dart';
import '../model/transfer_list_model.dart';
import '../model/update_transfer_model.dart';
import '../network/repository/transfer_repository.dart';

class TransferController extends ChangeNotifier {
  List<TransferHistory> listItem = [];
  UpdateTransferModel updateTransferModel = UpdateTransferModel();
  TransferItemResponse? transferItemResponse;
  late TransferView _view;
  late OnTransferStatusView _statusView;
  late OnProcessTransfer _onProcessTransferView;
  bool fetch = false;
  var materialData = {};
  Factory? factory;
  CollectionCenter? collectionCenter;
  PageState pageState = PageState.loaded;

  set onProcessView(v) {
    _onProcessTransferView = v;
  }

  set view(v) {
    _view = v;
  }

  set statusView(v) {
    _statusView = v;
  }

  set setCollectionCenter(v) {
    collectionCenter = v;
    notifyListeners();
  }

  set setFactory(v) {
    factory = v;
    notifyListeners();
  }

  set setTransferID(v) {
    updateTransferModel.id = v;
  }

  set setReason(v) {
    updateTransferModel.reason = v;
  }

  getTransferList(
    BuildContext context,
  ) async {
    if (fetch == false) {
      pageState = PageState.loading;
      requestList(context);
    }
  }

  refresh(BuildContext context) {
    pageState = PageState.loading;
    notifyListeners();
    listItem.clear();
    requestList(context);
  }

  requestList(BuildContext context) {
    TransferRepository.getTransfer().then((value) {
      if (value.status == true) {
        listItem.clear();
        listItem.addAll(value.transferHistory!);
        transferItemResponse = value;
      }
      pageState = PageState.loaded;
      fetch = true;
      notifyListeners();
    }).catchError((v) {
      _view.onError(context, "could not fetch item list");
      pageState = PageState.loaded;
      fetch = true;
      notifyListeners();
    });
  }

  submit(BuildContext context, WidgetRef ref, {bool forBailedTransfer = true}) {
    if (materialData.isNotEmpty) {
      materialData["item_id"] =
          transferItemResponse?.items?.first.id.toString();
      if (forBailedTransfer) {
        materialData["factory_id"] = factory?.id.toString();
      } else {
        materialData["toLocation"] = collectionCenter?.id.toString();
      }

      postSortingCall(context, ref, materialData,
          forBailedTransfer: forBailedTransfer);
    } else {
      _onProcessTransferView.onError(context, "Please add items");
    }
  }

  postSortingCall(BuildContext context, WidgetRef ref, Map data,
      {bool forBailedTransfer = true}) {
    pageState = PageState.loading;
    notifyListeners();
    TransferRepository.transfer(data, forBailedTransfer).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _onProcessTransferView.onSuccess(context, value.message!);
      } else {
        _onProcessTransferView.onError(context, value.message!);
      }
      _onProcessTransferView.onClearUI(ref);
    }).catchError((v) {
      _onProcessTransferView.onClearUI(ref);
      _onProcessTransferView.onError(context, v.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  updateStatus(BuildContext context) {
    pageState = PageState.loading;
    notifyListeners();
    TransferRepository.transferStatus(updateTransferModel.toJson())
        .then((value) {
      pageState = PageState.loaded;

      notifyListeners();
      if (value.status == true) {
        _statusView.onSuccess(context, value.message!);
        return;
      }
      _statusView.onError(context, value.message!);
    }).catchError((v) {
      _statusView.onError(context, v.toString());
      pageState = PageState.loaded;

      notifyListeners();
    });
  }

  getItemList(TransferHistory? item) {
    List<String> item = [];
    transferItemResponse?.transferItem?.forEach((element) {
      item.add(element.item ?? "");
    });

    return item;
  }

  getItemWeight(TransferHistory? history) {
    List<String> item = [];
    transferItemResponse?.transferItem?.forEach((element) {
      if (isNotEmpty(element.item)) {
        item.add(history?.toJson()[dbStringReplacer(element.item)]);
      }
    });
    String value = item
        .map((value) => int.parse(value))
        .reduce((value, element) => value + element)
        .toString();
    return value;
  }

  bool? haveItemsSelectedTransferItem(
      TransferItem itemData, BuildContext context) {
    bool exist = materialData.containsKey(dbStringReplacer(itemData.item));
    if (exist) {
      _onProcessTransferView.onError(
          context, "${itemData.item!} has been selected already");
      return true;
    }
    return false;
  }

  List<KeyValueModel> get getAvailableBailingMaterial {
    List<KeyValueModel> listOfKeyValue = [];
    Map breakDownMap = transferItemResponse!.bailedBreakdown!.toJson();
    transferItemResponse!.transferItem?.forEach((key) {
      if (breakDownMap.containsKey(key.item?.replaceAll(" ", "_"))) {
        listOfKeyValue.add(KeyValueModel(
            key: key.item,
            value: breakDownMap[key.item?.replaceAll(" ", "_")]));
      }
    });
    return listOfKeyValue;
  }

  List<KeyValueModel> get getAvailableSortedMaterial {
    List<KeyValueModel> listOfKeyValue = [];
    Map breakDownMap = transferItemResponse!.sortedBreakdown!.toJson();
    transferItemResponse!.transferItem?.forEach((key) {
      if (breakDownMap.containsKey(key.item?.replaceAll(" ", "_"))) {
        listOfKeyValue.add(KeyValueModel(
            key: key.item,
            value: breakDownMap[key.item?.replaceAll(" ", "_")]));
      }
    });
    return listOfKeyValue;
  }

  displayMessage(BuildContext context, String message) {
    _onProcessTransferView.onError(context, message);
  }

  clearTransferScreen() {
    listItem.clear();
    fetch = false;
  }

  clear() {
    materialData.clear();
    factory = null;
  }
}

abstract class OnProcessTransfer {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onClearUI(WidgetRef ref);
}

abstract class TransferView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}

abstract class OnTransferStatusView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}

abstract class OnSortedTransferStatusView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
