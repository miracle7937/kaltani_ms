import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../utils/string_helper.dart';
import '../model/key_value_model.dart';
import '../model/transfer_list_model.dart';
import '../model/update_transfer_model.dart';
import '../network/repository/transfer_repository.dart';

class TransferController extends ChangeNotifier {
  List<History> listItem = [];
  UpdateTransferModel updateTransferModel = UpdateTransferModel();
  TransferItemResponse? transferItemResponse;
  late TransferView _view;
  late OnTransferHistory _onTransferHistory;
  late OnTransferStatusView _statusView;
  late OnProcessTransfer _onProcessTransferView;
  bool fetch = false;
  bool isHistoryLoaded = false;
  Map<String, dynamic> bailMaterialData = {};
  String errorMassage = "";
  Map materialData = {};
  FactoryLocation? factory;
  FactoryLocation? collectionCenter;
  PageState pageState = PageState.loaded;
  TransferType? transferType;
  String totalTransferWeight = "0";

  setTransactionType(v) {
    transferType = v;
  }

  set setTotalTransferWeight(v) {
    totalTransferWeight = v;
  }

  set onProcessView(v) {
    _onProcessTransferView = v;
  }

  set view(v) {
    _view = v;
  }

  set statusView(v) {
    _statusView = v;
  }

  set onTransferHistoryView(v) {
    _onTransferHistory = v;
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

  String getUnsortedWeight() {
    return (transferType == TransferType.bailed
            ? transferItemResponse?.unsortedBailedTotal
            : transferItemResponse?.unsortedLooseTotal) ??
        "0";
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

  clearAll() {
    fetch = false;
  }

  requestList(BuildContext context) {
    TransferRepository.getTransfer().then((value) {
      if (value.status == true) {
        transferItemResponse = value;
      }
      pageState = PageState.loaded;
      fetch = true;
      notifyListeners();
    }).onError((v, t) {
      errorMassage = v.toString();
      _view.onError(context, errorMassage);
      pageState = PageState.error;
      fetch = true;
      notifyListeners();
    });
  }

  refreshHistory(BuildContext context) {
    pageState = PageState.loading;
    notifyListeners();
    isHistoryLoaded = false;
    getTransferHistory(context);
  }

  getTransferHistory(BuildContext context) {
    if (isHistoryLoaded == true) {
      return;
    }
    TransferRepository.getHistory().then((value) {
      if (value.status == true) {
        listItem.clear();
        listItem.addAll(value.history!);
      }
      pageState = PageState.loaded;
      isHistoryLoaded = true;
      notifyListeners();
    }).onError((v, t) {
      errorMassage = v.toString();
      _onTransferHistory.onError(context, errorMassage);
      pageState = PageState.loaded;
      isHistoryLoaded = true;
      notifyListeners();
    });
  }

  summitUnsorted(BuildContext context) {
    if ((double.parse(totalTransferWeight) <=
            double.parse(getUnsortedWeight())) &&
        int.parse(getUnsortedWeight()) <= 0) {
      _onProcessTransferView.onError(
          context, "Input weight must exceed total weight.");
      return;
    }

    if (factory == null) {
      _onProcessTransferView.onError(
          context, "Please selected transfer location");
      return;
    }
    Map data = {"unsorted": totalTransferWeight, "toLocation": factory?.id};

    pageState = PageState.loading;
    notifyListeners();
    TransferRepository.transferUnsorted(data, transferType).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _onProcessTransferView.onSuccess(context, value.message!);
      } else {
        _onProcessTransferView.onError(context, value.message!);
      }
    }).catchError((v) {
      _onProcessTransferView.onError(context, v.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  clearUnsorted() {
    factory = null;
    totalTransferWeight = "0";
  }

  submitSortedMaterial(
    BuildContext context,
  ) {
    if (materialData.isNotEmpty && collectionCenter != null) {
      materialData["toLocation"] = collectionCenter?.id.toString();

      postSortingCall(context, materialData);
    } else {
      _onProcessTransferView.onError(
          context, "Please provide all required field(s)");
    }
  }

  postSortingCall(
    BuildContext context,
    dynamic data,
  ) {
    pageState = PageState.loading;
    notifyListeners();
    TransferRepository.transfer(data, transferType).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status = true) {
        _onProcessTransferView.onSuccess(context, value.message!);
      } else {
        _onProcessTransferView.onError(context, value.message!);
      }
    }).catchError((v) {
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

  getItemList(History history) {
    String? keysString = history.data
        ?.toJson()
        .keys
        .join(", ")
        .replaceAll("_", " ")
        .toUpperCase();
    return keysString;
  }

  getItemWeight(History history) {
    int sum = 0;
    history.data?.toJson().forEach((key, value) {
      sum += int.parse(value);
    });

    return sum;
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

  List<KeyValueModel> get getAvailableSortedMaterial {
    List<KeyValueModel> listOfKeyValue = [];

    if (transferItemResponse!.bailedSortedBrakedown == null) {
      return listOfKeyValue;
    }

    if (transferType == TransferType.bailed) {
      transferItemResponse!.bailedSortedBrakedown?.forEach((element) {
        if (element.value != "0") {
          listOfKeyValue
              .add(KeyValueModel(key: element.key, value: element.value));
        }
      });
    } else {
      transferItemResponse!.looseSortedBrakedown?.forEach((element) {
        if (element.value != "0") {
          listOfKeyValue
              .add(KeyValueModel(key: element.key, value: element.value));
        }
      });
    }

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
    bailMaterialData.clear();
    factory = null;
  }

  addMaterial(String materialType, Map data) {
    bailMaterialData[materialType]?.addAll(data);
  }
}

enum TransferType { bailed, loose }

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

abstract class OnTransferHistory {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}

abstract class OnSortedTransferStatusView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
