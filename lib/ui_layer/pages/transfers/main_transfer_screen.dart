import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaltani_ms/ui_layer/pages/transfers/transfer_detail.dart';
import 'package:kaltani_ms/ui_layer/pages/transfers/transfer_screen.dart';

import '../../../logic/controller/transfer_controller.dart';
import '../../../logic/manager/controller_manager.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/reuseable/card_bg.dart';
import '../../../utils/reuseable/sliver_app_bar_delegate.dart';
import '../../../utils/reuseable/transfer_card.dart';
import '../../../utils/scaffolds_widget/ka_appbar.dart';
import '../../../utils/scaffolds_widget/ka_scaffold.dart';

class TransferMainPage extends ConsumerWidget with OnTransferHistory {
  const TransferMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransferController controller = ref.watch(transferManager)
      ..onTransferHistoryView = this
      ..getTransferHistory(context);
    return KAScaffold(
      appBar: KAppBar(
        backgroundColor: KAColors.appMainLightColor,
        title: const Text("Transfers"),
      ),
      state: AppState(
          pageState: controller.pageState,
          // noDataMessage: controller.errorMassage,
          onRetry: () {
            controller.refresh(context);
          }),
      builder: (_) => WillPopScope(
          child: RefreshIndicator(
              color: KAColors.appMainColor,
              child: CustomScrollView(
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
                                        builder: (_) => const TransferScreen(
                                              transferType: TransferType.bailed,
                                            )));
                              },
                              body: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Transfer Bailed Material",
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
                                        builder: (_) => const TransferScreen(
                                              transferType: TransferType.loose,
                                            )));
                              },
                              body: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Transfer Loose  Materials",
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
                  SliverList(
                    delegate: SliverChildListDelegate(
                      controller.listItem.isNotEmpty
                          ? [
                              const SizedBox(
                                height: 15,
                              ),
                              ...controller.listItem.reversed.map((value) =>
                                  TransferCard(
                                    transferData: value,
                                    callback: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => TransferDetail(
                                                    history: value,
                                                  )));
                                    },
                                  ))
                            ]
                          : [_emptyList(context)],
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                controller.refreshHistory(context);
              }),
          onWillPop: () {
            controller.clearTransferScreen();
            return Future.value(true);
          }),
    );
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
