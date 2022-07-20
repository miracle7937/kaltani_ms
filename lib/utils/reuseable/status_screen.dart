import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/images.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

class StatusScreen extends StatelessWidget {
  final String? title;
  const StatusScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KAScaffold(
      builder: (context) => Column(
        children: [
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.2,
            child: FlareActor(
              KAImages.successAnimation,
              animation: "Animation",
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          Text(
            title ?? "Your entries have been successfully submitted",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          KAButton(
            title: "OK",
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
