import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/logic/model/transfer_list_model.dart';

import '../../../logic/controller/transfer_controller.dart';
import '../../../logic/manager/controller_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/reuseable/KAForm.dart';
import '../../../utils/reuseable/custom_drop_down/ka_dropdown.dart';
import '../../../utils/reuseable/custom_snack_bar.dart';
import '../../../utils/reuseable/ka_button.dart';
import '../../../utils/reuseable/status_screen.dart';
import '../../../utils/scaffolds_widget/ka_appbar.dart';
import '../../../utils/scaffolds_widget/ka_scaffold.dart';
import '../../ui_logic/sorting_page_logic.dart';

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
              title: const Text("Transfer Unsorted Material"),
            ),
            builder: (_) {
              return RefreshIndicator(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Available Unsorted Material",
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${controller.getUnsortedWeight()} KG",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SYDropdownButton<FactoryLocation>(
                              itemsListTitle: "Select Location",
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
                              items: controller
                                  .transferItemResponse?.locationFactory
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
                          KAForm(
                            title: "Material Weight",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[0-9]*$')),
                            ],
                            onChange: (v) {
                              controller.setTotalTransferWeight = v;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          KAButton(
                            onTap: () {
                              controller.summitUnsorted(context);
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
                  });
            }),
        onWillPop: () async {
          controller.clearUnsorted();
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
    ref.watch(transferManager).clearUnsorted();
  }
}
