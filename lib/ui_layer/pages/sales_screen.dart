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
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
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
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                KAForm(
                  title: "Material  (ton)",
                  keyboardType: TextInputType.number,
                  onChange: (v) {
                    controller.setTon = v;
                  },
                ),
                // KAForm(
                //   keyboardType: TextInputType.number,
                //   title: "Amount",
                //   onChange: (v) {
                //     controller.setAmount = v;
                //   },
                // ),
                SYDropdownButton<String>(
                    itemsListTitle: "Select Currency",
                    iconSize: 22,
                    value: controller.saleSetModel.currency,
                    hint: const Text(""),
                    isExpanded: true,
                    underline: const Divider(),
                    // value: enrollController.selectedLocationModel,
                    searchMatcher: (item, text) {
                      return item.contains(text);
                    },
                    onChanged: (v) {
                      controller.setCurrency = v;
                    },
                    items: [
                      "NGN",
                      "USD",
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              )),
                        )
                        .toList()),
                const SizedBox(
                  height: 15,
                ),
                KAForm(
                  keyboardType: TextInputType.number,
                  title: "Price per ton",
                  onChange: (v) {
                    controller.setPricePerTon = v;
                  },
                ),
                KAForm(
                  keyboardType: TextInputType.number,
                  title: "Freight",
                  onChange: (v) {
                    controller.setFreight = v;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                controller.saleSetModel.currency != null
                    ? Text(
                        "${controller.saleSetModel.currency} ${controller.getTotalAmount()}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: KAColors.appBlackColor),
                      )
                    : Container(),
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
