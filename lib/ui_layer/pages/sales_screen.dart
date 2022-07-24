import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/controller/sales_controller.dart';
import 'package:kaltani_ms/utils/reuseable/KAForm.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_appbar.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../logic/manager/controller_manager.dart';
import '../../utils/colors.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/status_screen.dart';

class SalesScreen extends ConsumerWidget with SalesView {
  SalesScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SalesController controller = ref.watch(salesManager)..setView = this;

    return WillPopScope(
        child: KAScaffold(
          scaffoldKey: _scaffoldKey,
          appBar: KAppBar(
            backgroundColor: KAColors.appMainLightColor,
            title: const Text("Sales"),
          ),
          builder: (_) => Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              KAForm(
                title: "Material  (KG)",
                keyboardType: TextInputType.number,
                onChange: (v) {
                  controller.saleSetModel.itemWeight = v;
                },
              ),
              KAForm(
                keyboardType: TextInputType.number,
                title: "Amount",
                onChange: (v) {
                  controller.saleSetModel.amount = v;
                },
              ),
              const Spacer(),
              KAButton(
                loading: controller.pageState == PageState.loading,
                title: "SUBMIT",
                onTap: () {
                  controller.submitSales(context);
                },
              )
            ],
          ),
        ),
        onWillPop: () {
          controller.clearData();
          return Future.value(true);
        });
  }

  @override
  onError(BuildContext context, String message) async {
    await showSnackBar(message, context, key: _scaffoldKey);
  }

  @override
  onSuccess(BuildContext context, String message) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const StatusScreen()));
  }
}
