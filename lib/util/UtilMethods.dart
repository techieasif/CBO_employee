import 'package:intl/intl.dart';

class UtilMethods {
  static String getFormattedDate(final date) {
    try {
      return DateFormat.yMMMd().format(DateTime.parse(date));
    } catch (e) {
      return date;
    }
  }
}
