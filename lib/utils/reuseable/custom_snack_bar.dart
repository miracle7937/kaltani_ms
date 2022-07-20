import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/colors.dart';

import '../images.dart';

void showErrorSnackBar(String text,
    {required BuildContext context,
    GlobalKey<ScaffoldState>? key,
    SnackBarAction? action}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    duration: const Duration(milliseconds: 1700),
    backgroundColor: Colors.red,
    action: action,
  );
  if (key != null) {
    key.currentState!.showSnackBar(snackBar);
  } else {
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

Future<void> showSnackBar(String text, BuildContext? context,
    {GlobalKey<ScaffoldState>? key,
    SnackBarAction? action,
    Color? textColor,
    Color? backgroundColor,
    hide = true,
    Duration? duration,
    String? actionText,
    VoidCallback? callback}) async {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Container(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        InkWell(
            onTap: () => key!.currentState!.hideCurrentSnackBar(),
            child: Image.asset(KAImages.closeIcon)),
        const SizedBox(
          width: 10,
        )
      ],
    ),
    duration: duration ?? Duration(milliseconds: 2000),
    backgroundColor: KAColors.appMainColor,
    action: action,
  );
  if (key != null) {
    key.currentState!.showSnackBar(snackBar);
  } else {
    Scaffold.of(context!).showSnackBar(snackBar);
  }
}

void showInSnackBar(context, {String? value, Color? color}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 20000),
    backgroundColor: KAColors.appMainColor,
    content: Row(
      children: [
        Text(
          value!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ));
}
