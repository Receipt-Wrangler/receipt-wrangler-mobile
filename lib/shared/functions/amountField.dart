import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';

import '../../utils/forms.dart';

Widget amountField(
  String label,
  String fieldName,
  String initialAmount,
  WranglerFormState formState,
) {
  var amountMask = new CurrencyTextInputFormatter(
      decimalDigits: 2, enableNegative: false, symbol: "");
  return FormBuilderTextField(
    name: fieldName,
    decoration: InputDecoration(labelText: label, prefixText: "\$ "),
    keyboardType: TextInputType.number,
    initialValue: initialAmount,
    validator: FormBuilderValidators.required(),
    readOnly: isFieldReadOnly(formState),
    inputFormatters: [amountMask],
  );
}