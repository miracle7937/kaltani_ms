import 'package:flutter/material.dart';
import 'package:kaltani_ms/logic/model/auth_set_model.dart';
import 'package:kaltani_ms/logic/network/exceptions.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../local_storage.dart';
import '../network/repository/auth_repository.dart';

class AuthController extends ChangeNotifier {
  late AuthView _authView;
  AuthSetModel authSetModel = AuthSetModel();
  PageState pageState = PageState.loaded;
  setView(v) {
    _authView = v;
  }

  set setEmail(String mail) {
    authSetModel.email = mail;
  }

  set setPassword(String password) {
    authSetModel.password = password;
  }

  authenticateUser(BuildContext context) {
    if (authSetModel.isValid()) {
      pageState = PageState.loading;
      notifyListeners();
      AuthRepository.login(authSetModel).then((value) {
        pageState = PageState.loaded;
        notifyListeners();
        if (value.token != null) {
          //success
          saveUser(value.toJson());
          _authView.onSuccess(context);
          return;
        }
        _authView.onError("");
        //error
      }).catchError((onError) {
        _authView.onError((onError as CustomException).message!);

        pageState = PageState.loaded;
        notifyListeners();
      });
    }
  }
}

abstract class AuthView {
  onSuccess(BuildContext context);
  onError(String message);
}
