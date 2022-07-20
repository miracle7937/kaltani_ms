import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/reuseable/ka_button.dart';
import '../../utils/scaffolds_widget/ka_scaffold.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KAScaffold(
      builder: (_) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Your entries have been successfully submitted",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: KAColors.appGreyColor),
            ),
          ),
          KAButton(
            title: "HOME",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const StatusScreen()));
            },
          )
        ],
      ),
    );
  }
}
