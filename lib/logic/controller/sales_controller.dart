import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../model/sales_set_model.dart';
import '../network/repository/sales_repository.dart';

class SalesController with ChangeNotifier {
  SaleSetModel saleSetModel = SaleSetModel();
  PageState pageState = PageState.loaded;
  SalesView? _view;
  set setView(v) {
    _view = v;
  }

  submitSales(BuildContext context) {
    if (saleSetModel.isValid) {
      pageState = PageState.loading;
      notifyListeners();
      SalesRepository.sales(saleSetModel.toJson()).then((value) {
        pageState = PageState.loaded;
        notifyListeners();
        if (value.status == true) {
          _view?.onSuccess(context, value.message!);
          return;
        }
        _view?.onError(context, value.message!);
      }).catchError((v) {
        pageState = PageState.loaded;
        notifyListeners();
        _view?.onError(context, v.toString());
      });
    } else {
      _view?.onError(context, "Form(s) can't be empty");
    }
  }

  clearData() {
    saleSetModel = SaleSetModel();
  }
}

abstract class SalesView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
