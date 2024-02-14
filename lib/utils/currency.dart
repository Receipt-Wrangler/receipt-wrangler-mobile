import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  return NumberFormat.currency(decimalDigits: 2, name: "\$").format(amount);
}
