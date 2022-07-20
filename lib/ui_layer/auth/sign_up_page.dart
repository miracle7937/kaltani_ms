import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/controller/auth_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../utils/scaffolds_widget/page_state.dart';
import '../dashboard/dashboard.dart';

class SignUpPage extends ConsumerWidget with AuthView {
  SignUpPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthController authController = ref.watch(authManager);
    authController.setView(this);
    return KAScaffold(
      scaffoldKey: _scaffoldKey,
      padding: EdgeInsets.zero,
      builder: (_) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
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
                    "Login",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: KAColors.appBlackColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  KAForm(
                    hintText: "Enter your email address",
                    title: "Email",
                    onChange: (v) {
                      authController.setEmail = v;
                    },
                  ),
                  KAForm(
                      hintText: "Enter your Password",
                      title: "Password",
                      forPassword: true,
                      onChange: (v) {
                        authController.setPassword = v;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  KAButton(
                    loading: authController.pageState == PageState.loading,
                    title: "Login",
                    onTap: () {
                      authController.authenticateUser(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "V1.3.0",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: KAColors.appBlackColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) async {
    await showSnackBar(message, null, key: _scaffoldKey);
  }

  @override
  onSuccess(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const DashBoard()));
  }
}
