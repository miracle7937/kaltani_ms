import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/reuseable/KAForm.dart';

import '../../logic/controller/recyle_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../utils/colors.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/reuseable/status_screen.dart';
import '../../utils/scaffolds_widget/ka_appbar.dart';
import '../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../utils/scaffolds_widget/page_state.dart';

class RecycleScreen extends ConsumerWidget with RecycleView {
  RecycleScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecycleController controller = ref.watch(recycleManager)..setView = this;
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
                title: "Material Input (KG)",
                onChange: (v) {
                  controller.recycleSetModel.itemWeightInput = v;
                },
              ),
              KAForm(
                title: "Material Output(KG)",
                onChange: (v) {
                  controller.recycleSetModel.itemWeightOutput = v;
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
