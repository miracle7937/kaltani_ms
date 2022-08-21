import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/auth_response_model.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../utils/null_checker.dart';
import '../../utils/string_helper.dart';
import '../manager/controller_manager.dart';
import '../model/key_value_model.dart';
import '../model/sales_bailed_breakdown.dart';
import '../model/sales_set_model.dart';
import '../network/repository/sales_repository.dart';

class SalesController with ChangeNotifier {
  SaleSetModel saleSetModel = SaleSetModel();
  PageState pageState = PageState.loaded;
  SalesView? _view;
  SalesMaterials? salesMaterials;
  List<Location>? locations;
  Location? selectLocation;
  bool fetch = false;
  bool fetchLoanBreakDown = false;
  BailedBreakdownResponse? bailedBreakdownResponse;
  List<KeyValueModel> listOfKeyValue = [];
  Map<String, dynamic> materialData = {};
  setMaterial(SalesMaterials v, WidgetRef ref) {
    salesMaterials = v;
    ref.watch(sortingPageLogicManager).clear();
    notifyListeners();
  }

  setLocation(Location v) {
    selectLocation = v;
    notifyListeners();
  }

  set setView(v) {
    _view = v;
  }

  set setTon(v) {
    saleSetModel.itemWeight = v;
    notifyListeners();
  }

  set setCurrency(v) {
    saleSetModel.currency = v;
    notifyListeners();
  }

  set setCustomerName(v) {
    saleSetModel.customerName = v;
    notifyListeners();
  }

  set setFreight(v) {
    saleSetModel.freight = v;
    notifyListeners();
  }

  set setPricePerTon(v) {
    saleSetModel.pricePerTon = v;
    notifyListeners();
  }

  set setAmount(v) {
    saleSetModel.amount = v;
    notifyListeners();
  }

  initialize(BuildContext context) {
    if (fetch == false) {
      pageState = PageState.loading;
      SalesRepository.getLocation().then((value) {
        if (value.status == true) {
          locations = value.data;
        }
        pageState = PageState.loaded;
        fetch = true;
        notifyListeners();
      }).catchError((v) {
        _view?.onError(context, v.toString());
        pageState = PageState.error;
        fetch = true;
        notifyListeners();
      });
    }
  }

  getBailedBreakDown(BuildContext context, id) {
    fetchLoanBreakDown = true;
    notifyListeners();
    SalesRepository.getBailedBreakDown(id).then((value) {
      if (value.status == true) {
        bailedBreakdownResponse = value;
      }
      fetchLoanBreakDown = false;
      listOfKeyValue.clear();
      notifyListeners();
    }).catchError((onError) {
      fetchLoanBreakDown = false;
      listOfKeyValue.clear();
      notifyListeners();
      _view?.onError(context, onError.toString());
    });
  }

  submitSales(BuildContext context, WidgetRef ref) {
    if (saleSetModel.isValid && salesMaterials != null) {
      pageState = PageState.loading;
      notifyListeners();
      Map body = {};
      if (salesMaterials == SalesMaterials.bailed) {
        body.addAll(saleSetModel.toJson());
        body.addAll(materialData);
      } else {
        body.addAll(saleSetModel.toJson());
      }
      body.addAll({"amount": getTotalAmount()});
      body.addAll({"collection_id": selectLocation?.id.toString()});
      salesBase(context, ref, salesMaterials!, body);
      log(body.toString());
      //set amount
    } else {
      _view?.onError(context, "Form(s) can't be empty");
    }
  }

  salesBase(BuildContext context, WidgetRef ref, SalesMaterials salesMaterials,
      Map body) {
    SalesRepository.sales(body, salesMaterials).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status == true) {
        _view?.onSuccess(context, value.message!);
      }
      _view?.onPop(context, ref, value.message!);
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      _view?.onPop(context, ref, v.toString());
    });
  }

  List<KeyValueModel> get getAvailableBailedMaterial {
    listOfKeyValue.clear();
    if (bailedBreakdownResponse?.bailedBreakdown != null) {
      Map? breakDownMap = bailedBreakdownResponse?.bailedBreakdown!.toJson();
      bailedBreakdownResponse!.bailingItems?.forEach((key) {
        var amountValue = breakDownMap![key.item?.replaceAll(" ", "_")];
        if (breakDownMap.containsKey(key.item?.replaceAll(" ", "_")) &&
            amountValue != "0") {
          listOfKeyValue.add(KeyValueModel(key: key.item, value: amountValue));
        }
      });
    }
    return listOfKeyValue;
  }

  bool? haveItemsSelectedBailing(BailingItems itemData, BuildContext context) {
    bool exist = materialData.containsKey(dbStringReplacer(itemData.item));
    if (exist) {
      _view?.onError(context, "${itemData.item!} has been selected already");
      return true;
    }
    return false;
  }

  addMaterial(String materialType, Map data) {
    materialData[materialType].addAll(data);
  }

  displayMessage(BuildContext context, String message) {
    _view?.onError(context, message);
  }

  List<BailingItems>? sortNetWorkItem() {
    //usSorted
    // transferItemResponse?.transferItem
    return bailedBreakdownResponse?.bailingItems
        ?.where((element) =>
            !["Trash", "Clean Clear", "Caps"].contains(element.item))
        .toList();
  }

  clearData() {
    saleSetModel = SaleSetModel();
    salesMaterials = null;
    materialData.clear();
  }

  num getTotalAmount() {
    return (isValueEmpty(saleSetModel.itemWeight) *
        isValueEmpty(saleSetModel.pricePerTon));
  }

  num isValueEmpty(String? value) => isEmpty(value) ? 0 : num.parse(value!);
}

abstract class SalesView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
  onPop(BuildContext context, WidgetRef ref, String message);
}

enum SalesMaterials { bailed, flakes }
