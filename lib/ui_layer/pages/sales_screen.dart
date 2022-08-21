import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/controller/sales_controller.dart';
import 'package:kaltani_ms/logic/model/auth_response_model.dart';
import 'package:kaltani_ms/utils/reuseable/KAForm.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_appbar.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/page_state.dart';

import '../../logic/manager/controller_manager.dart';
import '../../logic/model/sales_bailed_breakdown.dart';
import '../../utils/amount_formatter.dart';
import '../../utils/colors.dart';
import '../../utils/null_checker.dart';
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/status_screen.dart';
import '../../utils/string_helper.dart';
import '../ui_logic/sorting_page_logic.dart';

class SalesScreen extends ConsumerWidget with SalesView {
  SalesScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SalesController controller = ref.watch(salesManager)
      ..setView = this
      ..initialize(context);
    SortingPageLogic sortingPageLogic = ref.watch(sortingPageLogicManager);

    return WillPopScope(
        child: KAScaffold(
          scaffoldKey: _scaffoldKey,
          state: AppState(pageState: controller.pageState),
          appBar: KAppBar(
            backgroundColor: KAColors.appMainLightColor,
            title: const Text("Sales"),
          ),
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                KAForm(
                  keyboardType: TextInputType.name,
                  title: "Customer Name",
                  onChange: (v) {
                    controller.setCustomerName = v;
                  },
                ),
                SYDropdownButton<SalesMaterials>(
                    itemsListTitle: "Material Type",
                    iconSize: 22,
                    hint: const Text(""),
                    isExpanded: true,
                    underline: const Divider(),
                    value: controller.salesMaterials,
                    searchMatcher: (item, text) {
                      return true;
                    },
                    onChanged: (v) {
                      controller.setMaterial(v, ref);
                    },
                    items: SalesMaterials.values
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              )),
                        )
                        .toList()),
                KAForm(
                  title: "Material  (ton)",
                  keyboardType: TextInputType.number,
                  onChange: (v) {
                    controller.setTon = v;
                  },
                ),
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
                controller.salesMaterials == SalesMaterials.bailed
                    ? SizedBox(
                        child: WidgetBuilderView(
                        sortingPageLogic: sortingPageLogic,
                      ))
                    : Container(),
                controller.saleSetModel.currency != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.saleSetModel.currency} ${amountFormatter(controller.getTotalAmount())}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: KAColors.appBlackColor),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          isNotEmpty(controller.saleSetModel.freight)
                              ? Text(
                                  "Freight  NGN ${amountFormatter(num.parse(controller.saleSetModel.freight ?? "0.0"))}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: KAColors.appBlackColor),
                                )
                              : Container(),
                        ],
                      )
                    : Container(),
                KAButton(
                  loading: controller.pageState == PageState.loading,
                  title: "SUBMIT",
                  onTap: () {
                    controller.submitSales(context, ref);
                  },
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          controller.clearData();
          sortingPageLogic.clear();

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

  @override
  onPop(BuildContext context, WidgetRef ref, String message) async {
    await showSnackBar(message, context, key: _scaffoldKey).whenComplete(() {
      ref.watch(sortingPageLogicManager).clear();
      ref.watch(salesManager).clearData();
    });
  }
}

class WidgetBuilderView extends ConsumerWidget {
  const WidgetBuilderView({Key? key, required this.sortingPageLogic})
      : super(key: key);
  final SortingPageLogic sortingPageLogic;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SalesController controller = ref.watch(salesManager);

    return Column(
      children: [
        buildWidget(context, controller),
        controller.fetchLoanBreakDown == true
            ? Center(
                child: CircularProgressIndicator(
                  color: KAColors.appMainColor,
                ),
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        controller.getAvailableBailedMaterial.isNotEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: controller.getAvailableBailedMaterial.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: KAColors.appMainColor,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 5)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  "${controller.getAvailableBailedMaterial[index].key!} - ${controller.getAvailableBailedMaterial[index].value!}kg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
              )
            : Container(),
        controller.getAvailableBailedMaterial.isNotEmpty
            ? Column(
                children: sortingPageLogic.forItemList.map((e) {
                  return e;
                }).toList(),
              )
            : Container(),
        controller.getAvailableBailedMaterial.isNotEmpty
            ? Row(
                children: [
                  KAButton(
                    onTap: () {
                      sortingPageLogic.addItem(FormUI(
                        ref: ref,
                        index: sortingPageLogic.forItemList.length,
                      ));
                    },
                    bgColor: Colors.green,
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.add),
                  ),
                  const Spacer(),
                  KAButton(
                    onTap: () {
                      sortingPageLogic
                          .removeItem(sortingPageLogic.forItemList.length - 1);
                    },
                    bgColor: Colors.red,
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.cancel),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  Widget buildWidget(BuildContext context, SalesController controller) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SYDropdownButton<Location>(
            itemsListTitle: "Select Location",
            iconSize: 22,
            value: controller.selectLocation,
            hint: const Text(""),
            isExpanded: true,
            underline: const Divider(),
            // value: enrollController.selectedLocationModel,
            searchMatcher: (item, text) {
              return item.name!.contains(text);
            },
            onChanged: (v) {
              controller.setLocation(v);
              controller.getBailedBreakDown(context, v.id.toString());
            },
            items: controller.locations
                ?.map(
                  (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.black,
                            ),
                      )),
                )
                .toList()),
      ],
    );
  }
}

class FormUI extends StatefulWidget {
  final WidgetRef? ref;
  final int index;
  const FormUI({Key? key, this.ref, required this.index}) : super(key: key);

  @override
  State<FormUI> createState() => _FormUIState();
}

class _FormUIState extends State<FormUI> {
  BailingItems? _itemData;
  var addValue = {};
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SalesController? controller = widget.ref?.watch(salesManager);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: SYDropdownButton<BailingItems>(
                itemsListTitle: "Select item type",
                iconSize: 22,
                value: _itemData,
                hint: const Text(""),
                isExpanded: true,
                underline: const Divider(),
                searchMatcher: (item, text) {
                  return item.item!.toLowerCase().contains(text.toLowerCase());
                },
                onChanged: (v) {
                  bool? exist =
                      controller?.haveItemsSelectedBailing(v, context);
                  if (exist == false) {
                    _itemData = v;
                    controller
                        ?.materialData[dbStringReplacer(_itemData?.item)] = {};
                    setState(() {});
                  }
                },
                items: controller
                    ?.sortNetWorkItem()
                    ?.map(
                      (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.item!,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Colors.black,
                                    ),
                          )),
                    )
                    .toList()),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: KAForm(
            keyboardType: TextInputType.number,
            padding: EdgeInsets.zero,
            title: "Weight",
            onChange: (v) {
              if (_itemData != null) {
                // addValue[dbStringReplacer(_itemData?.item)] = v;
                // controller?.materialData.addAll(addValue);
                controller?.addMaterial(
                    dbStringReplacer(_itemData?.item), {"total_weight": v});
              } else {
                textController.clear();
                controller?.displayMessage(
                    context, "Select item type before inputting value");
              }
            },
          )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: KAForm(
            keyboardType: TextInputType.number,
            padding: EdgeInsets.zero,
            title: "QTY",
            onChange: (v) {
              if (_itemData != null) {
                controller?.addMaterial(
                    dbStringReplacer(_itemData?.item), {"quantity": v});
              } else {
                textController.clear();
                controller?.displayMessage(
                    context, "Select item type before inputting value");
              }
            },
          )),
        ],
      ),
    );
  }
}
