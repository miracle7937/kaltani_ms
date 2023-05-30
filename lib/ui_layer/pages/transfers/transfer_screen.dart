import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/ui_layer/pages/transfers/transfer_process_screen.dart';
import 'package:kaltani_ms/ui_layer/pages/transfers/transfer_sorted_material_screen.dart';
import 'package:kaltani_ms/utils/images.dart';
import 'package:kaltani_ms/utils/reuseable/card_bg.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_appbar.dart';

import '../../../logic/controller/transfer_controller.dart';
import '../../../logic/manager/controller_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/reuseable/sliver_app_bar_delegate.dart';
import '../../../utils/scaffolds_widget/ka_scaffold.dart';

class TransferScreen extends ConsumerWidget with TransferView {
  final TransferType transferType;
  const TransferScreen({Key? key, required this.transferType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransferController controller = ref.watch(transferManager)
      ..view = this
      ..setTransactionType(transferType)
      ..getTransferList(context);
    return KAScaffold(
      state: AppState(pageState: controller.pageState),
      appBar: KAppBar(
        backgroundColor: KAColors.appMainLightColor,
        title: Text(transferType == TransferType.bailed
            ? "Transfers Bailed Material"
            : "Transfers Sorted Material"),
      ),
      builder: (_) => CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: MediaQuery.of(context).size.height * 0.2,
              maxHeight: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  CardBG(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TransferSortedScreen()));
                      },
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Transfer Sorted Material",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  CardBG(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TransferProcessScreen()));
                      },
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Transfer Unsorted Material",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // TransferController controller = ref.watch(transferManager)
    //   ..view = this
    //   ..getTransferList(context);
    // return KAScaffold(
    //     state: AppState(pageState: controller.pageState),
    //     floatingActionButton: FloatingActionButton(
    //       backgroundColor: KAColors.appMainColor,
    //       onPressed: () {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (_) => TransferProcessScreen()));
    //       },
    //       child: const Icon(Icons.add),
    //     ),
    //     appBar: KAppBar(
    //       backgroundColor: KAColors.appMainLightColor,
    //       title: const Text("Transfer"),
    //     ),
    //     builder: (_) => WillPopScope(
    //         child: controller.listItem.isNotEmpty
    //             ? RefreshIndicator(
    //                 color: KAColors.appMainColor,
    //                 child: ListView.builder(
    //                     itemCount: controller.listItem.length,
    //                     itemBuilder: (_, index) => TransferCard(
    //                           transferData: controller.listItem[index],
    //                           callback: () {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (_) => TransferDetail(
    //                                           history:
    //                                               controller.listItem[index],
    //                                         )));
    //                           },
    //                         )),
    //                 onRefresh: () async {
    //                   controller.refresh(context);
    //                 })
    //             : _emptyList(context),
    //         onWillPop: () {
    //           controller.clearTransferScreen();
    //           return Future.value(true);
    //         })
    // );
  }

  _emptyList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(KAImages.emptyTransferIcon),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              "No transfer available Click the + sign to add new",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w400, color: KAColors.appGreyColor),
            ),
          )
        ],
      ),
    );
  }

  @override
  onError(BuildContext context, String message) {}

  @override
  onSuccess(BuildContext context, String message) {}
}
