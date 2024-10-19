import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';

import '../../models/system_settings_model.dart';
import '../../utils/forms.dart';

Widget amountField(BuildContext context, String label, String fieldName,
    String initialAmount, WranglerFormState formState,
    {Key? key}) {
  var systemSettingsModel = Provider.of<SystemSettingsModel>(context);
  var hideDecimalPlaces = systemSettingsModel.currencyHideDecimalPlaces;
  var doubleAmount = double.parse(initialAmount);

  var controller = CurrencyTextFieldController(
      decimalSymbol: hideDecimalPlaces
          ? ""
          : getCurrencySeparatorLiteral(
              systemSettingsModel.currencyDecimalSeparator),
      thousandSymbol: getCurrencySeparatorLiteral(
          systemSettingsModel.currencyThousandSeparator),
      initDoubleValue: doubleAmount,
      numberOfDecimals: hideDecimalPlaces ? 0 : 2,
      currencySymbol: "",
      startWithSeparator: true,
      forceCursorToEnd: false);

  var prefix = systemSettingsModel.currencySymbolPosition ==
          api.CurrencySymbolPosition.START
      ? systemSettingsModel.currencyDisplay
      : null;

  var suffix = systemSettingsModel.currencySymbolPosition ==
          api.CurrencySymbolPosition.END
      ? systemSettingsModel.currencyDisplay
      : null;

  return FormBuilderTextField(
    key: key,
    name: fieldName,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefix,
      suffixText: suffix,
    ),
    keyboardType: TextInputType.number,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      //FormBuilderValidators.numeric(),
      //FormBuilderValidators.min(0, inclusive: false),
    ]),
    readOnly: isFieldReadOnly(formState),
    controller: controller,
    valueTransformer: (value) {
      return exchangeCustomToUSD(value);
    },
  );
}
