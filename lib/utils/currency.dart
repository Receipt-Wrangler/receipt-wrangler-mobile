import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/currency.dart';

import '../models/system_settings_model.dart';

String formatCurrency(BuildContext context, double amount) {
  var systemSettingsModel = Provider.of<SystemSettingsModel>(context);
  return NumberFormat.currency(
          decimalDigits: 2, name: systemSettingsModel.currencyDisplay)
      .format(amount);
}

String getCurrencySeparatorLiteral(CurrencySeparator separator) {
  switch (separator) {
    case CurrencySeparator.comma:
      return ',';
    case CurrencySeparator.period:
      return '.';
    default:
      return '';
  }
}

void registerCustomCurrency(BuildContext context) {
  var systemSettingsModel =
      Provider.of<SystemSettingsModel>(context, listen: false);

  var currency = Currency.create(
    customCurrencyISOCode,
    systemSettingsModel.currencyHideDecimalPlaces ? 0 : 2,
    name: customCurrencyISOCode,
    symbol: systemSettingsModel.currencyDisplay,
    groupSeparator: getCurrencySeparatorLiteral(
        systemSettingsModel.currencyThousandSeparator),
    decimalSeparator: getCurrencySeparatorLiteral(
        systemSettingsModel.currencyDecimalSeparator),
  );

  Currencies().register(currency);
}

String exchangeCustomToUSD(String? customValue) {
  if (customValue == null || customValue.isEmpty) {
    return "0";
  }

  var parsedCustomValue =
      Money.parse(customValue, isoCode: customCurrencyISOCode);

  ExchangeRate exchangeRate = ExchangeRate.fromNum(1,
      decimalDigits: 2, fromCode: customCurrencyISOCode, toCode: "USD");

  var usdValue = exchangeRate.applyRate(parsedCustomValue);
  return usdValue.amount.toString();
}
