import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class KAButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool? loading, active;
  final String? title;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  const KAButton(
      {Key? key,
      this.onTap,
      this.title,
      this.loading = false,
      this.bgColor,
      this.active = true,
      this.padding,
      this.child})
      : super(key: key);

  @override
  _KAButtonState createState() => _KAButtonState();
}

class _KAButtonState extends State<KAButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            // If the button is pressed, return green, otherwise blue
            if (states.contains(MaterialState.pressed)) {
              return KAColors.appGreyColor;
            }
            return widget.bgColor ??
                (widget.active!
                    ? KAColors.appMainColor
                    : KAColors.appGreyColor);
          }),
        ),
        // splashColor: Colors.red,
        onPressed: () => (widget.loading ?? false) ? null : widget.onTap!(),
        child: SizedBox(
            height: 55,
            child: Center(
              child: (widget.loading ?? false)
                  ? const CircularProgressIndicator(
                      strokeWidth: 1.5,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    )
                  : widget.child == null
                      ? Text(
                          widget.title ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )
                      : Center(
                          child: widget.child,
                        ),
            )
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(6.0),
            //     color:),
            ),
      ),
    );
  }
}
