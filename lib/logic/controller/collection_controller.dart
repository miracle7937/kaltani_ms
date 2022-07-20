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
  }

  collect(
    BuildContext context,
  ) async {
    pageState = PageState.loading;
    notifyListeners();
    //set userinfo
    AuthResponse userInfo = await getUserData();
    collectionSetData.location = userInfo.user?.location;
    collectionSetData.userId = userInfo.user?.id.toString();

    CollectionRepository.process(collectionSetData).then((value) {
      pageState = PageState.loaded;
      notifyListeners();
      if (value.status == true) {
        _collectionView.onSuccess(context, value.message!);
      } else {
        _collectionView.onError(value.message!);
      }
    }).catchError((onError) {
      // error

      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  collectionList() {
    if (itemList.isEmpty) {
      CollectionRepository.getCollectionItemList().then((value) {
        if (value.status == true && value.data != null) {
          itemList.addAll(value.data!);
        }
      }).catchError((e) {
        _collectionView.onError("");
      });
    }
  }
}

abstract class CollectionView {
  onSuccess(BuildContext context, String message);
  onError(String message);
}
