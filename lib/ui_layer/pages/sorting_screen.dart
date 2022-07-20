import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/sort_item_model.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../logic/controller/sorting_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../logic/model/item_response.dart';
import '../../utils/colors.dart';
import '../../utils/reuseable/KAForm.dart';
import '../../utils/reuseable/card_bg.dart';
import '../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../utils/reuseable/custom_snack_bar.dart';
import '../../utils/scaffolds_widget/ka_appbar.dart';
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
    // if (sortingPageLogic.forItemList.isEmpty) {
    //   ref
    //       .watch(sortingPageLogicManager)
    //       .forItemList
    //       .add(formUI(context, sortingPageLogic, ref));
    // }
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
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Available Material",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              CardBG(
                color: KAColors.appMainColor,
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Plastic",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "10KG",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: sortingPageLogic.forItemList.length,
                      itemBuilder: (context, index) {
                        Widget formUI =
                            (sortingPageLogic.forItemList[index] as FormUI);

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
                      controller.addSortedItem();
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
                      controller
                          .removeSortedItem(controller.sortiedItem.length - 1);
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
                  controller.submit(context);
                  // controller.sortiedItem.forEach((element) {
                  //   log("${element.sortItem} ------> ${element.sortItemWeight}");
                  // });
                },
                padding: EdgeInsets.zero,
                title: "Submit",
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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
    await showSnackBar(message, context, key: _scaffoldKey);
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
  ItemData? _itemData;
  @override
  Widget build(BuildContext context) {
    SortedItem item =
        widget.ref!.watch(sortingManager).sortiedItem[widget.index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 5,
            child: SYDropdownButton<ItemData>(
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
                      .haveItemsSelected(v, context);
                  print("${item.sortItem} =========> ${v.id}");
                  if (exist == false || item.sortItem == v.id.toString()) {
                    _itemData = v;
                    item.sortItem = v.id.toString();
                    item.itemName = v.item.toString();
                  }
                  setState(() {});
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
            keyboardType: TextInputType.number,
            padding: EdgeInsets.zero,
            title: "",
            onChange: (v) {
              item.sortItemWeight = v;
            },
          )),
        ],
      ),
    );
  }
}
