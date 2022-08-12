import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/logic/model/collection_item_response.dart';
import 'package:kaltani_ms/utils/null_checker.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../local_storage.dart';
import '../model/auth_response_model.dart';
import '../model/collection_set_data.dart';
import '../network/repository/collection_repository.dart';

class CollectionController extends ChangeNotifier {
  late CollectionView _collectionView;
  List<CollectionData> itemList = [];
  CollectionData? selectedCollection;
  CollectionSetData collectionSetData = CollectionSetData();
  PageState pageState = PageState.loaded;

  setView(v) {
    _collectionView = v;
  }

  set setCollection(v) {
    selectedCollection = v;
    notifyListeners();
  }

  set setItemWeight(v) {
    collectionSetData.itemWeight = v;
    notifyListeners();
  }

  set setPricePerKG(v) {
    collectionSetData.pricePerKg = v;
    notifyListeners();
  }

  set setTransport(v) {
    collectionSetData.transport = v;
    notifyListeners();
  }

  set setOther(v) {
    collectionSetData.others = v;
    notifyListeners();
  }

  set setLoader(v) {
    collectionSetData.loader = v;
    notifyListeners();
  }

  collect(
    BuildContext context,
  ) async {
    pageState = PageState.loading;
    notifyListeners();
    //set userinfo
    AuthResponse userInfo = await getUserData();
    collectionSetData.location = userInfo.user?.location?.id.toString();
    collectionSetData.userId = userInfo.user?.id.toString();
    collectionSetData.item = selectedCollection!.id.toString();
    collectionSetData.amount = getTotalAmount().toString();
    log(collectionSetData.toJson().toString());
    CollectionRepository.process(collectionSetData).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status == true) {
        _collectionView.onSuccess(context, value.message!);
        clear();
      } else {
        _collectionView.onError(context, value.message!);
      }
    }).catchError((onError) {
      // error
      _collectionView.onError(context, onError.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  collectionList(BuildContext context) {
    if (itemList.isEmpty) {
      pageState = PageState.loading;
      CollectionRepository.getCollectionItemList().then((value) {
        if (value.status == true && value.data != null) {
          itemList.addAll(value.data!);
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((e) {
        pageState = PageState.loaded;
        notifyListeners();
        _collectionView.onError(context, "");
      });
    }
  }

  getTotalAmount() {
    return (isValueEmpty(collectionSetData.itemWeight) *
            isValueEmpty(collectionSetData.pricePerKg)) +
        isValueEmpty(collectionSetData.transport) +
        isValueEmpty(collectionSetData.loader) +
        isValueEmpty(collectionSetData.others);
  }

  num isValueEmpty(String? value) => isEmpty(value) ? 0 : num.parse(value!);

  clear() {
    collectionSetData = CollectionSetData();
  }
}

abstract class CollectionView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
