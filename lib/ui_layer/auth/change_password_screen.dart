import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/reuseable/status_screen.dart';

import '../../logic/controller/change_password_controller.dart';
import '../../logic/local_storage.dart';
import '../../logic/manager/controller_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../utils/scaffolds_widget/page_state.dart';

class ChangePasswordScreen extends ConsumerWidget with ChangeAuthView {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChangePasswordController changePasswordController =
        ref.watch(changePasswordManager);
    changePasswordController.setView(this);
    return KAScaffold(
      scaffoldKey: _scaffoldKey,
      padding: EdgeInsets.zero,
      builder: (_) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              color: KAColors.appMainLightColor,
              child: SizedBox(
                child: Image.asset(
                  KAImages.logo,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: KAColors.appBlackColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  KAForm(
                      hintText: "Enter your old Password",
                      title: "Old Password",
                      forPassword: true,
                      onChange: (v) {
                        changePasswordController.setOldPassword = v;
                      }),
                  KAForm(
                      hintText: "Enter your new Password",
                      title: "New Password",
                      forPassword: true,
                      onChange: (v) {
                        changePasswordController.setNewPassword = v;
                      }),
                  KAForm(
                      hintText: "Confirm password",
                      title: "Confirm Password",
                      forPassword: true,
                      onChange: (v) {
                        changePasswordController.setConfirmPassword = v;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  KAButton(
                    loading:
                        changePasswordController.pageState == PageState.loading,
                    title: "Login",
                    onTap: () {
                      changePasswordController.changePassword(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  onError(BuildContext context, String message) async {
    await showSnackBar(message, null, key: _scaffoldKey);
  }

  @override
  onSuccess(BuildContext context, String message) {
    clearUser();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => StatusScreen(
                  title: message,
                )));
  }
}
