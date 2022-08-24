import 'package:intl/intl.dart';

amountFormatter(num number) {
  final oCcy = NumberFormat("#,###", "en_US");
  return oCcy.format(number);
}
