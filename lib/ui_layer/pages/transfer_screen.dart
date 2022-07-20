import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/images.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../utils/colors.dart';
import '../../utils/reuseable/transfer_card.dart';
import '../../utils/scaffolds_widget/ka_appbar.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KAScaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: KAColors.appMainColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: KAppBar(
        backgroundColor: KAColors.appMainLightColor,
        title: const Text("Transfer"),
      ),
      builder: (_) => Column(
        children: [_emptyList(context), const TransferCard()],
      ),
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
}
