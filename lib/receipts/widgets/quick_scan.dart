import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/user_preferences_model.dart';

class QuickScan extends StatefulWidget {
  const QuickScan({
    super.key,
  });

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _buildGroupField() {
    int? initialValue;
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    if (userPreferencesModel.userPreferences.quickScanDefaultGroupId > 0) {
      initialValue =
          userPreferencesModel.userPreferences.quickScanDefaultGroupId;
    }

    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      initialValue: initialValue,
      items: buildGroupDropDownMenuItems(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            _buildGroupField(),
          ],
        ));
  }
}
