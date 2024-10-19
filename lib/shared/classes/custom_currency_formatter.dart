import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

class CustomCurrencyFormatter extends TextInputFormatter {
  final String currencySymbol;
  final CurrencySeparator currencyDecimalSeparator;
  final CurrencySeparator currencyThousandthsSeparator;
  final CurrencySymbolPosition currencySymbolPosition;
  final bool currencyHideDecimalPlaces;

  CustomCurrencyFormatter({
    required this.currencySymbol,
    required this.currencyDecimalSeparator,
    required this.currencyThousandthsSeparator,
    required this.currencySymbolPosition,
    this.currencyHideDecimalPlaces = false,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If deleting values, allow it without interfering
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Removing any non-numeric or non-decimal characters except the allowed currencyDecimalSeparator
    String cleanText = newValue.text
        .replaceAll(RegExp(r'[^\d${currencyDecimalSeparator}]'), '');

    // Parse the clean text as a number (if possible)
    double? value = double.tryParse(cleanText.replaceAll(".", '.'));

    // Handle invalid input or all zeros case
    if (value == null) return newValue;

    // Format the number using the intl package (without symbol and with locale separators)
    String formattedValue = NumberFormat.currency(
      symbol: '',
      decimalDigits: currencyHideDecimalPlaces ? 0 : 2,
    ).format(value);

    // Replace '.' with the user-specified decimal separator
    if (currencyDecimalSeparator != '.') {
      formattedValue = formattedValue.replaceAll('.', ",");
    }

    // Replace ',' with the user-specified thousandths separator
    if (currencyThousandthsSeparator != ',') {
      formattedValue = formattedValue.replaceAll(',', ".");
    }

    // Add currency symbol at the correct position
    if (currencySymbolPosition == CurrencySymbolPosition.START) {
      formattedValue = '$currencySymbol$formattedValue';
    } else if (currencySymbolPosition == CurrencySymbolPosition.END) {
      formattedValue = '$formattedValue$currencySymbol';
    }

    // Calculate the new cursor position
    int newCursorPosition =
        formattedValue.length - (newValue.text.length - newValue.selection.end);

    // Return the formatted value with the updated cursor position
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(
          offset: newCursorPosition.clamp(0, formattedValue.length)),
    );
  }
}
