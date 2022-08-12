import 'package:flutter/cupertino.dart';

import '../../utils/scaffolds_widget/page_state.dart';
import '../model/change_password_set_model.dart';
import '../network/repository/auth_repository.dart';

class ChangePasswordController with ChangeNotifier {
  late ChangeAuthView _authView;
  ChangePasswordModel changePasswordModel = ChangePasswordModel();

  PageState pageState = PageState.loaded;
  setView(v) {
    _authView = v;
  }

  set setOldPassword(String v) {
    changePasswordModel.oldPassword = v;
  }

  set setNewPassword(String v) {
    changePasswordModel.newPassword = v;
  }

  set setConfirmPassword(String v) {
    changePasswordModel.confirmPassword = v;
  }

  changePassword(BuildContext context) {
    if (changePasswordModel.newPassword !=
        changePasswordModel.confirmPassword) {
      _authView.onError(context, "password didn't match try again");
      return;
    }
    if (changePasswordModel.isValid()) {
      pageState = PageState.loading;
      notifyListeners();
      AuthRepository.changePassword(changePasswordModel).then((value) {
        pageState = PageState.loaded;
        notifyListeners();
        if (value.status == true) {
          _authView.onSuccess(context, value.message.toString());
          return;
        }
        _authView.onError(context, value.message.toString());
        //error
      }).catchError((onError) {
        _authView.onError(context, onError.toString());

        pageState = PageState.loaded;
        notifyListeners();
      });
    }
  }
}

abstract class ChangeAuthView {
  onSuccess(BuildContext context, String message);
  onError(BuildContext context, String message);
}
