import 'package:intl/intl.dart';

class DateFormatHelper {
  static String formatDate(String date) {
    DateTime formattedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(formattedDate);
  }
}
