import 'package:intl/intl.dart';

const defaultDateFormat = "MM/dd/yyyy";

const zuluDateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";

formatDate(String dateFormat, DateTime date) {
  var formatter = DateFormat(dateFormat);
  return formatter.format(date);
}
