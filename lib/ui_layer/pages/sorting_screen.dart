import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../logic/controller/sorting_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../logic/model/sorting_item_response.dart';
import '../../utils/colors.dart';
import '../../utils/null_checker.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/card_bg.dart';
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/reuseable/status_screen.dart';
import '../../utils/scaffolds_widget/ka_appbar.dart';
import '../../utils/string_helper.dart';
import '../ui_logic/sorting_page_logic.dart';

class SortingScreen extends ConsumerWidget with SortingView {
  SortingScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SortingController controller = ref.watch(sortingManager)
      ..fetItemList(context)
      ..setView(this);
    SortingPageLogic sortingPageLogic = ref.watch(sortingPageLogicManager);
    return WillPopScope(
        child: KAScaffold(
            scaffoldKey: _scaffoldKey,
            state: AppState(
              pageState: controller.pageState,
            ),
            appBar: KAppBar(
              backgroundColor: KAColors.appMainLightColor,
              title: const Text("Sorting"),
            ),
            builder: (_) => RefreshIndicator(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Available Material",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CardBG(
                          color: KAColors.appMainColor,
                          body: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Plastic",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        isNotEmpty(controller
                                                .sortingItemResponse
                                                ?.totalCollected)
                                            ? "${controller.sortingItemResponse?.totalCollected} KG"
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Unsorted",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${controller.unsortedWeight}KG",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10,
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
                            log(controller.materialData.toString());
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
                })),
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
  onClearUI(WidgetRef ref) async {
    ref.watch(sortingPageLogicManager).clear();
    ref.watch(sortingManager).clear();
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
  SortingItems? _itemData;
  var addValue = {};
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SortingController controller = widget.ref!.watch(sortingManager);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: SYDropdownButton<SortingItems>(
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
                      .read(sortingManager)
                      .haveItemsSelectedSorting(v, context);
                  if (exist == false) {
                    _itemData = v;
                    addValue[dbStringReplacer(_itemData?.item)] = "0";
                    //setting it the controller
                    controller.materialData.addAll(addValue);
                    setState(() {});
                  }
                },
                items: widget.ref!
                    .watch(sortingManager)
                    .itemDataList
                    .map(
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
            controller: textController,
            keyboardType: TextInputType.number,
            padding: EdgeInsets.zero,
            title: "Weight(KG)",
            onChange: (v) {
              if (_itemData != null) {
                addValue[dbStringReplacer(_itemData?.item)] = v;
                controller.materialData.addAll(addValue);
                widget.ref!.read(sortingManager).unsorted();
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
