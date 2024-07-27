import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';

import '../../models/system_settings_model.dart';
import '../../utils/forms.dart';

Widget amountField(BuildContext context, String label, String fieldName,
    String initialAmount, WranglerFormState formState,
    {Key? key}) {
  var systemSettingsModel = Provider.of<SystemSettingsModel>(context);

  var amountMask = new CurrencyTextInputFormatter(
      NumberFormat.decimalPatternDigits(decimalDigits: 2),
      enableNegative: false);
  return FormBuilderTextField(
    key: key,
    name: fieldName,
    decoration: InputDecoration(
        labelText: label, prefixText: systemSettingsModel.currencyDisplay),
    keyboardType: TextInputType.number,
    initialValue: initialAmount,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.min(0, inclusive: false),
    ]),
    readOnly: isFieldReadOnly(formState),
    inputFormatters: [amountMask],
  );
}
