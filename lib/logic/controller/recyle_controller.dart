import 'package:flutter/cupertino.dart';
import 'package:kaltani_ms/logic/model/recycle_set_model.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../network/repository/recycle_repository.dart';

class RecycleController extends ChangeNotifier {
  RecycleSetModel recycleSetModel = RecycleSetModel();
  PageState pageState = PageState.loaded;
  RecycleView? _view;
  set setView(v) {
    _view = v;
  }

  submitSales(BuildContext context) {
    if (recycleSetModel.isValid) {
      pageState = PageState.loading;
      notifyListeners();
      RecycleRepository.recycle(recycleSetModel.toJson()).then((value) {
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
    recycleSetModel = RecycleSetModel();
  }
}

abstract class RecycleView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
