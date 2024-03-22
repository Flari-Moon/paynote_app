import 'package:intl/intl.dart';

class DateConversionUtils {
  static String dateToString(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}