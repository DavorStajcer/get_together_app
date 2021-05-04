import 'package:intl/intl.dart';

class DateFormater {
  static String getDashFormat(DateTime dateToFormat) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateToFormat);
  }

  static String getDotFormat(DateTime dateToFormat) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateToFormat);
  }
}
