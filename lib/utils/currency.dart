import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/system_settings_model.dart';

String formatCurrency(BuildContext context, double amount) {
  var systemSettingsModel = Provider.of<SystemSettingsModel>(context);
  return NumberFormat.currency(
          decimalDigits: 2, name: systemSettingsModel.currencyDisplay)
      .format(amount);
}
