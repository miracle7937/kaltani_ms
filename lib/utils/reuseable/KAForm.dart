import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class KAForm extends StatefulWidget {
  final String? setValue;
  final String? labelText, hintText, suffixText, title;
  final bool? forPassword, enable;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor,
      inputTextColor,
      focusedBorderColor,
      enabledBorderColor,
      disabledBorderColor,
      labelColor,
      border;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon, suffixWidget, peffixIcon;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final VoidCallback? callback;
  final int? maxLines, maxLength;

  const KAForm(
      {Key? key,
      this.enable = true,
      this.labelText,
      this.hintText,
      this.forPassword = false,
      this.padding,
      this.fillColor,
      this.contentPadding,
      this.onChange,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.inputTextColor,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.labelColor,
      this.hintStyle,
      this.disabledBorderColor,
      this.suffixText,
      this.border,
      this.suffixWidget,
      this.peffixIcon,
      this.callback,
      this.setValue = "",
      this.maxLines,
      this.maxLength,
      this.title})
      : super(key: key);

  @override
  _SYFormState createState() => _SYFormState();
}

class _SYFormState extends State<KAForm> {
  bool showPassword = true;

  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    controller!.text = widget.setValue!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: widget.padding ??
            const EdgeInsets.symmetric(
              vertical: 10,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? "",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w600, color: KAColors.appBlackColor),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: widget.callback,
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  controller: controller,
                  enabled: widget.enable,
                  onChanged: widget.onChange,
                  cursorColor: KAColors.appMainColor,
                  obscureText: widget.forPassword! && showPassword,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: KAColors.appBlackColor),
                  decoration: InputDecoration(
                      prefixIcon: widget.peffixIcon,
                      suffixIcon: widget.suffixWidget,
                      suffixText: widget.suffixText,
                      contentPadding:
                          widget.contentPadding ?? const EdgeInsets.all(15),
                      fillColor: widget.fillColor ?? KAColors.appWhiteColor,
                      filled: true,
                      suffix: widget.forPassword!
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: showPassword
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: KAColors.appMainColor,
                                      size: 15,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: KAColors.appMainColor,
                                      size: 15,
                                    ))
                          : (widget.suffixIcon),
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      labelStyle: TextStyle(
                          color: widget.labelColor ?? KAColors.appMainColor),
                      hintStyle: widget.hintStyle ??
                          const TextStyle(color: Colors.grey),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.disabledBorderColor ??
                                  KAColors.appGreyColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.enabledBorderColor ??
                                  const Color(0xffbfc9da))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: KAColors.appGreyColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.focusedBorderColor ??
                                  KAColors.appMainColor))),
                ),
              ),
            )
          ],
        ));
  }
}
