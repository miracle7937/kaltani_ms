import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/colors.dart';

import '../../null_checker.dart';
import '../custom_drop_down/cupertino_bottom_sheet.dart';
import '../custom_drop_down/selection_list_bottom.dart';
import '../ka_button.dart';

_createDialogWidget(
  BuildContext context,
  String title,
  String message,
  String buttonText,
  VoidCallback callback, {
  String? image,
  String? flareAsset,
  bool displayAd = false,
}) {
  assert(!isEmpty(title));
  assert(!isEmpty(message));
  assert(!isEmpty(buttonText));
  return _createExtensibleDialogWidget(
      ListBody(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 4,
                width: 70,
                color: Colors.black12,
              ),
            ),
          ),
          Visibility(
            visible: isNotEmpty(flareAsset!) || isNotEmpty(image!),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: SizedBox(
                width: 100,
                height: 100,
                child: isNotEmpty(flareAsset)
                    ? FlareActor(
                        flareAsset,
                        animation: "Animation",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        image!,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              key: Key(message),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: KAColors.appMainLightColor,
                  ),
            ),
          )),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          ),
          KAButton(
            title: buttonText,
            onTap: callback,
            key: const Key('continue_button'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
          )
        ],
      ),
      borderRadius: BorderRadius.circular(15));
}

Future showBottomSheetDialog<T>(
  BuildContext context, {
  String? title,
  String? message,
  String? buttonText,
  VoidCallback? callback,
  String? icon,
  String? flareAsset,
  bool dismissible = true,
  bool displayAd = false,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: dismissible,
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (BuildContext context) {
        return GestureDetector(
            child: _createDialogWidget(
          context,
          title!,
          message!,
          buttonText!,
          callback ?? () {},
          image: icon,
          flareAsset: flareAsset,
          displayAd: displayAd,
        ));
      });
}

_createExtensibleDialogWidget(
  Widget body, {
  BorderRadiusGeometry? borderRadius,
  EdgeInsetsGeometry? padding,
}) {
  return SafeArea(
    child: Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: KAColors.appWhiteColor,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
        ),
        child: SingleChildScrollView(
          child: body,
        ),
      ),
    ),
  );
}

Future<T?>? showIVBottomSheetList<T>({
  Key? key,
  required BuildContext context,
  required List<T> items,
  Future<List<T>>? itemsFuture,
  required Widget Function(T) itemBuilder,
  required ValueChanged<T> onItemSelected,
  String? title,
  bool hasSearch = false,
  bool Function(T, String)? searchMatcher,
  bool? shouldPop = true,
  String? searchHint,
  String? noDataMessage,
  Color seperatorColor = const Color(0xffEFEFEF),
  Map<String, SegregationFunction<T>>? segregationMap,
  TextStyle? defaultSegregationTitleStyle,
  EdgeInsets? segregationTitlePadding,
  Map<String, TextStyle>? segregationTitlesStylesMap,
  bool hideSegregationTitle = false,
  String? favoriteTitle,
  List<T>? favoriteItems,
  String Function(T item)? favItemBuilder,
}) {
  return showIVModalBottomSheet<T>(
    context: context,
    isDismissible: true,
    expand: true,
    body: SelectionListBottomSheet<T>(
      title: title ?? '',
      items: items,
      itemsFuture: itemsFuture,
      itemBuilder: itemBuilder,
      onItemSelected: onItemSelected,
      hasSearch: hasSearch,
      searchMatcher: searchMatcher,
      shouldPop: shouldPop!,
      searchHint: searchHint,
      noDataMessage: noDataMessage,
      seperatorColor: seperatorColor,
      segregationMap: segregationMap,
      defaultSegregationTitleStyle: defaultSegregationTitleStyle,
      segregationTitlePadding: segregationTitlePadding,
      segregationTitlesStylesMap: segregationTitlesStylesMap,
      hideSegregationTitle: hideSegregationTitle,
      favoritesTitle: favoriteTitle,
      favoriteItems: favoriteItems,
      favItemBuilder: favItemBuilder,
    ),
  );
}

void showPhoneList(BuildContext context, List<String> recipients,
    ValueChanged<String> valueChanged) {
  showIVBottomSheetList<String>(
    hasSearch: true,
    searchMatcher: (String recipient, String b) {
      return [
        recipient,
      ].any((String? it) => it!.contains(b));
    },
    title: "Mobile Number",
    context: context,
    items: recipients,
    itemBuilder: (String r) {
      //${r.phones.first.number.toString()}
      return DropdownMenuItem(
        child: Text(
          "${r} ",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
    },
    onItemSelected: valueChanged,
  );
}

Future<T?>? showIVModalBottomSheet<T>({
  required BuildContext context,
  required Widget body,
  bool expand = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  Color? barrierColor,
  bool enableDrag = true,
  AnimationController? secondAnimation,
  bool bounce = false,
  Duration duration = const Duration(milliseconds: 400),
  double closeProgressThreshold = 0.6,
  Radius topRadius = const Radius.circular(12),
}) {
  return showCupertinoModalBottomSheet<T>(
    context: context,
    expand: expand,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    barrierColor: barrierColor,
    enableDrag: enableDrag,
    secondAnimation: secondAnimation,
    bounce: bounce,
    duration: duration,
    closeProgressThreshold: closeProgressThreshold,
    backgroundColor: KAColors.appMainColor,
    topRadius: topRadius,
    builder: (context) {
      return Material(
        child: body,
        //use  controller: ModalScrollController.of(context), in the body for closing while scrolling
      );
    },
  );
}
