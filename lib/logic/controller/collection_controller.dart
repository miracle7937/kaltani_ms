import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/logic/model/collection_item_response.dart';

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

  collect(
    BuildContext context,
  ) async {
    pageState = PageState.loading;
    notifyListeners();
    //set userinfo
    AuthResponse userInfo = await getUserData();
    collectionSetData.location = userInfo.user?.locations?.id.toString();
    collectionSetData.userId = userInfo.user?.id.toString();
    collectionSetData.item = selectedCollection!.id.toString();
    log(collectionSetData.toJson().toString());
    CollectionRepository.process(collectionSetData).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status == true) {
        _collectionView.onSuccess(context, value.message!);
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
}

abstract class CollectionView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
