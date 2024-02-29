import 'package:intl/intl.dart';

const defaultDateFormat = "MM/dd/yyyy";

formatDate(String dateFormat, DateTime date) {
  var formatter = DateFormat(dateFormat);
  return formatter.format(date);
}
