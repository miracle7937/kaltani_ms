import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_appbar.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../logic/controller/collection_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../logic/model/collection_item_response.dart';
import '../../utils/amount_formatter.dart';
import '../../utils/colors.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/reuseable/status_screen.dart';
import '../../utils/scaffolds_widget/page_state.dart';

class CollectionScreen extends ConsumerWidget with CollectionView {
  CollectionScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CollectionController controller = ref.watch(collectionManager);
    controller.setView(this);
    controller.collectionList(context);
    return WillPopScope(
        child: KAScaffold(
          state: AppState(pageState: controller.pageState),
          scaffoldKey: _scaffoldKey,
          appBar: KAppBar(
            backgroundColor: KAColors.appMainLightColor,
            title: const Text("Collection"),
          ),
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SYDropdownButton<CollectionData>(
                    itemsListTitle: "Select item type",
                    iconSize: 22,
                    value: controller.selectedCollection,
                    hint: const Text(""),
                    isExpanded: true,
                    underline: const Divider(),
                    // value: enrollController.selectedLocationModel,
                    searchMatcher: (item, text) {
                      return item.item!.contains(text);
                    },
                    onChanged: (v) {
                      controller.setCollection = v;
                    },
                    items: controller.itemList
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.item.toString(),
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
                  height: 20,
                ),
                SYDropdownButton<String>(
                    itemsListTitle: "Collection Type",
                    iconSize: 22,
                    value: controller.selectedType,
                    hint: const Text(""),
                    isExpanded: true,
                    underline: const Divider(),
                    searchMatcher: (item, text) {
                      return item.contains(text);
                    },
                    onChanged: (v) {
                      controller.setCollectionType = v;
                    },
                    items: controller.collectionType
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString().toUpperCase(),
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
                  height: 10,
                ),
                KAForm(
                  title: "Enter item weight (KG)",
                  onChange: (v) {
                    controller.setItemWeight = v;
                  },
                  keyboardType: TextInputType.number,
                ),
                KAForm(
                  title: "Price Per KG",
                  onChange: (v) {
                    controller.setPricePerKG = v;
                  },
                  keyboardType: TextInputType.number,
                ),
                KAForm(
                  title: "Transport",
                  onChange: (v) {
                    controller.setTransport = v;
                  },
                  keyboardType: TextInputType.number,
                ),
                KAForm(
                  title: "Loader",
                  onChange: (v) {
                    controller.setLoader = v;
                  },
                  keyboardType: TextInputType.number,
                ),
                KAForm(
                  title: "Others",
                  onChange: (v) {
                    controller.setOther = v;
                  },
                  keyboardType: TextInputType.number,
                ),
                Text(
                  "TOTAL AMOUNT",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: KAColors.appGreyColor),
                ),
                Text(
                  "NGN ${amountFormatter(controller.getTotalAmount())}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: KAColors.appBlackColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                KAButton(
                  loading: PageState.loading == controller.pageState,
                  title: "SUBMIT",
                  onTap: () {
                    controller.collect(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          controller.clear();
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
        context,
        MaterialPageRoute(
            builder: (_) => StatusScreen(
                  title: message,
                )));
  }
}
