import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaltani_ms/utils/reuseable/card_bg.dart';

import '../../logic/model/transfer_list_model.dart';
import '../colors.dart';

class TransferCard extends StatelessWidget {
  final TransferHistory? transferData;
  final VoidCallback? callback;
  const TransferCard({Key? key, this.transferData, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CardBG(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      transferData?.id.toString() ?? "",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: KAColors.appGreyColor),
                    ),
                    const Spacer(),
                    statusWidget(context, transferData?.status!, () {})
                  ],
                ),
                Row(
                  children: [
                    const Indicator(),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tile(context,
                            title: "Collection Center",
                            value: transferData?.location?.name ?? ""),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _tile(context,
                                title: "Factory",
                                value: transferData?.factory?.name ?? ""),
                            Text(
                              DateFormat('yMd').format(DateTime.parse(
                                  transferData!.location!.createdAt!)),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: KAColors.appGreyColor),
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  statusWidget(BuildContext context, status, VoidCallback callback) {
    Color? color;
    String? text;
    if (status == "0") {
      color = Colors.orangeAccent;
      text = "Pending";
    } else if (status == "1") {
      color = Colors.green;
      text = "Completed";
    } else {
      color = Colors.red;
      text = "Rejected";
    }
    return InkWell(
      onTap: () {
        if (status == "0") {
          callback();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w400, color: KAColors.appWhiteColor),
          ),
        ),
      ),
    );
  }

  _tile(BuildContext context, {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: FontWeight.bold, color: KAColors.appGreyColor),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: FontWeight.w400, color: KAColors.appGreyColor),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
        Container(
          width: 2,
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.black,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
