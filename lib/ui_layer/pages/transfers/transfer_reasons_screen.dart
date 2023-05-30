import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/reuseable/KAForm.dart';

import '../../../logic/controller/transfer_controller.dart';
import '../../../logic/manager/controller_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/reuseable/custom_snack_bar.dart';
import '../../../utils/reuseable/ka_button.dart';
import '../../../utils/reuseable/status_screen.dart';
import '../../../utils/scaffolds_widget/ka_appbar.dart';
import '../../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../../utils/scaffolds_widget/page_state.dart';

class TransferReasonsScreen extends ConsumerWidget {
  TransferReasonsScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransferController controller = ref.watch(transferManager);

    return KAScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: KAppBar(
        backgroundColor: KAColors.appMainLightColor,
        title: const Text("Transfer Detail"),
      ),
      builder: (_) => Column(
        children: [
          KAForm(
            controller: formController,
          ),
          KAButton(
            loading: controller.pageState == PageState.loading,
            onTap: () {
              controller.updateTransferModel.status = "2";
              controller.updateTransferModel.reason = formController.text;
              controller.updateStatus(context);
            },
            title: "SUBMIT",
          )
        ],
      ),
    );
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
