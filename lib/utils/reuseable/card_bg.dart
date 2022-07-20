import 'package:flutter/material.dart';

class CardBG extends StatelessWidget {
  final Widget body;
  final Color? color;
  final VoidCallback? callback;
  const CardBG({Key? key, required this.body, this.color, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        key: key,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? Colors.white,
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 5)
            ]),
        child: body,
      ),
    );
  }
}
