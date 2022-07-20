import 'package:flutter/material.dart';
import 'package:kaltani_ms/utils/reuseable/ka_button.dart';

class ErrorSwitcher extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message, subMessage;
  final dynamic error;

  const ErrorSwitcher({
    this.onRetry,
    this.error,
    required this.message,
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return _ErrorWidget(
      message: message!,
      onRetry: onRetry!,
      subMessage: subMessage!,
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  _ErrorWidget({
    Key? key,
    this.onRetry,
    required this.message,
    this.subMessage,
  }) : super(key: key);

  final VoidCallback? onRetry;
  final String? message, subMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          // Image.asset(
          //   IVImages.ivConnection,
          //   fit: BoxFit.contain,
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Something went wrong",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey,
                  fontSize: 18,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "connection error",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KAButton(
                title: "Retry",
                onTap: onRetry,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
