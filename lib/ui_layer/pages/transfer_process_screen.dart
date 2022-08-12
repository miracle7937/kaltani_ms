import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/transfer_list_model.dart';

import '../../logic/controller/transfer_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../utils/colors.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/reuseable/status_screen.dart';
import '../../utils/scaffolds_widget/ka_appbar.dart';
import '../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../utils/string_helper.dart';
import '../ui_logic/sorting_page_logic.dart';

class TransferProcessScreen extends ConsumerWidget with OnProcessTransfer {
  TransferProcessScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SortingPageLogic sortingPageLogic = ref.watch(sortingPageLogicManager);
    TransferController controller = ref.watch(transferManager)
      ..onProcessView = this;
    return WillPopScope(
        child: KAScaffold(
          scaffoldKey: _scaffoldKey,
          state: AppState(
            pageState: controller.pageState,
          ),
          appBar: KAppBar(
            backgroundColor: KAColors.appMainLightColor,
            title: const Text("Transfer"),
          ),
          builder: (_) => RefreshIndicator(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Available Bailed Material",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      controller.getAvailableBailingMaterial.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: ListView.builder(
                                  itemCount: controller
                                      .getAvailableBailingMaterial.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: KAColors.appMainColor,
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.15),
                                                    blurRadius: 5)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                "${controller.getAvailableBailingMaterial[index].key} - ${controller.getAvailableBailingMaterial[index].value}kg",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                            )
                          : Container(),
                      const SizedBox(
                        height: 15,
                      ),
                      SYDropdownButton<Factory>(
                          itemsListTitle: "Select Factory",
                          iconSize: 22,
                          value: controller.factory,
                          hint: const Text(""),
                          isExpanded: true,
                          underline: const Divider(),
                          searchMatcher: (item, text) {
                            return item.name!
                                .toLowerCase()
                                .contains(text.toLowerCase());
                          },
                          onChanged: (v) {
                            controller.setFactory = v;
                          },
                          items: controller.transferItemResponse?.factory
                              ?.map(
                                (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name!,
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
                      Expanded(
                          child: ListView.builder(
                              itemCount: sortingPageLogic.forItemList.length,
                              itemBuilder: (context, index) {
                                Widget formUI =
                                    (sortingPageLogic.forItemList[index]);

                                return formUI;
                              })),
                      Row(
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
                              sortingPageLogic.removeItem(
                                  sortingPageLogic.forItemList.length - 1);
                            },
                            bgColor: Colors.red,
                            padding: EdgeInsets.zero,
                            child: const Icon(Icons.cancel),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      KAButton(
                        onTap: () {
                          controller.submit(context, ref);
                        },
                        padding: EdgeInsets.zero,
                        title: "Submit",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
              onRefresh: () async {
                controller.refresh(context);
              }),
        ),
        onWillPop: () async {
          sortingPageLogic.clear();
          controller.clear();
          return Future.value(true);
        });
  }

  @override
  onError(BuildContext context, String message) async {
    await showSnackBar(message, context, key: _scaffoldKey);
  }

  @override
  onSuccess(BuildContext context, String message) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => StatusScreen(
                  title: message,
                )));
  }

  @override
  onClearUI(WidgetRef ref) {
    ref.watch(sortingPageLogicManager).clear();
    ref.watch(transferManager).clear();
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
  TransferItem? _itemData;
  var addValue = {};
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransferController controller = widget.ref!.watch(transferManager);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: SYDropdownButton<TransferItem>(
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
                  bool? exist = widget.ref!
                      .read(transferManager)
                      .haveItemsSelectedTransferItem(v, context);
                  if (exist == false) {
                    _itemData = v;
                    addValue[dbStringReplacer(_itemData?.item)] = "0";
                    //setting it the controller
                    controller.materialData.addAll(addValue);
                    setState(() {});
                  }
                },
                items: widget.ref!
                    .watch(transferManager)
                    .transferItemResponse
                    ?.transferItem
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
            title: "",
            onChange: (v) {
              if (_itemData != null) {
                addValue[dbStringReplacer(_itemData?.item)] = v;
                controller.materialData.addAll(addValue);
              } else {
                textController.clear();
                controller.displayMessage(
                    context, "Select item type before inputting value");
              }
            },
          )),
        ],
      ),
    );
  }
}
