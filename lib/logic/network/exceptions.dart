import '../../utils/null_checker.dart';

class CustomException implements Exception {
  String? message;
  String? prefix;
  int? responseCode;

  CustomException([this.message, this.prefix, this.responseCode]);

  @override
  String toString() => !isEmpty(message!) ? message! : "Something went wrong";
  String toDetailedString() => '$prefix: $message: $responseCode';
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message, responseCode])
      : super(message, "Unauthorised", responseCode);
}

class NotFoundException extends CustomException {
  NotFoundException([message, responseCode])
      : super(message, "Not found", responseCode);
}

class BadRequestException extends CustomException {
  BadRequestException([message, responseCode])
      : super(message, "Bad Request", responseCode);
}

class InvalidDetailsException extends CustomException {
  InvalidDetailsException([message, responseCode])
      : super(message, "Invalid On-boarding details", responseCode);
}

class BadFormatException extends CustomException {
  BadFormatException({message, responseCode})
      : super(
            message ?? "Bad Response Error", "Format Exception", responseCode);
}
