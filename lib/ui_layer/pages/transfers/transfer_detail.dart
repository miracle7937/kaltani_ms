import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/transfer_list_model.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../../logic/controller/transfer_controller.dart';
import '../../../logic/manager/controller_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/reuseable/card_bg.dart';
import '../../../utils/reuseable/custom_snack_bar.dart';
import '../../../utils/reuseable/status_screen.dart';
import '../../../utils/reuseable/transfer_card.dart';
import '../../../utils/scaffolds_widget/ka_appbar.dart';
import '../../../utils/scaffolds_widget/ka_scaffold.dart';

class TransferDetail extends ConsumerWidget with OnTransferStatusView {
  final History history;
  TransferDetail({Key? key, required this.history}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransferController controller = ref.watch(transferManager)
      ..setTransferID = history.id.toString()
      ..statusView = this;

    return KAScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: KAppBar(
        backgroundColor: KAColors.appMainLightColor,
        title: const Text("Transfer Detail"),
      ),
      builder: (_) => SingleChildScrollView(
        child: Column(
          children: [
            TransferCard(
              transferData: history,
            ),
            const SizedBox(
              height: 15,
            ),
            CardBG(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "More Information",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: KAColors.appGreyColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _cell(context, "Materials",
                              controller.getItemList(history).toString()),
                        ),
                        const Spacer(),
                        Expanded(
                          child: _cell(context, "Weight",
                              "${controller.getItemWeight(history)}KG"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: _cell(context, "Processed by",
                                history.staffName ?? "")),
                        const Spacer(),
                        Expanded(
                            child: _cell(
                                context, "Factory", history.address ?? ""))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (v) {
                controller.setReason = v;
              },
              maxLines: 4,
              cursorColor: KAColors.appMainColor,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: KAColors.appBlackColor),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: KAColors.appMainColor),
                  hintStyle: const TextStyle(color: Colors.grey),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KAColors.appGreyColor)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffbfc9da))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: KAColors.appGreyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KAColors.appMainColor))),
            ),
            const SizedBox(
              height: 20,
            ),
            KAButton(
              loading: controller.pageState == PageState.loading,
              onTap: () {
                controller.updateTransferModel.status = "1";
                controller.updateTransferModel.reason = "";
                controller.updateStatus(context);
              },
              title: "ACCEPT",
            )
          ],
        ),
      ),
    );
  }

  Widget _cell(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: FontWeight.bold, color: KAColors.appGreyColor),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w400, color: KAColors.appGreyColor),
        ),
      ],
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
