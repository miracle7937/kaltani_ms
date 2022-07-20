import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/reuseable/card_bg.dart';

import '../colors.dart';

class TransferCard extends StatelessWidget {
  const TransferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardBG(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "KLY44633744",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: KAColors.appGreyColor),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Pending",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: KAColors.appWhiteColor),
                    ),
                  ),
                )
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
                        value: "Oshodi Collection Center"),
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
                            title: "Factory", value: "Sagamu Factory"),
                        Text(
                          "22/06/2022",
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
