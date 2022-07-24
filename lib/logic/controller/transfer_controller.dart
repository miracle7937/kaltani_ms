import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../model/transfer_list_model.dart';
import '../network/repository/transfer_repository.dart';

class TransferController extends ChangeNotifier {
  List<TransferHistory> listItem = [];
  TransferItemResponse? transferItemResponse;
  late TransferView _view;
  bool fetch = false;
  PageState pageState = PageState.loaded;
  set view(v) {
    _view = v;
  }

  getTransferList(BuildContext context) async {
    if (fetch == false) {
      pageState = PageState.loading;
      TransferRepository.getTransfer().then((value) {
        if (value.status == true) {
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
  }
}

abstract class TransferView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
