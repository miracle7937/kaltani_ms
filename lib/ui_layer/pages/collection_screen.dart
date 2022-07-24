import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_appbar.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../logic/controller/collection_controller.dart';
import '../../logic/manager/controller_manager.dart';
import '../../logic/model/collection_item_response.dart';
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
    return KAScaffold(
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
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Colors.black,
                                    ),
                          )),
                    )
                    .toList()),
            KAForm(
              title: "Enter item weight (KG)",
              onChange: (v) {
                controller.collectionSetData.itemWeight = v;
              },
              keyboardType: TextInputType.number,
            ),
            KAForm(
              title: "Amount",
              onChange: (v) {
                controller.collectionSetData.amount = v;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
            ),
            KAButton(
              loading: PageState.loading == controller.pageState,
              title: "SUBMIT",
              onTap: () {
                controller.collect(context);
              },
            ),
          ],
        ),
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
        context,
        MaterialPageRoute(
            builder: (_) => StatusScreen(
                  title: message,
                )));
  }
}
