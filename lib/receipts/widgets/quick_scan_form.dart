import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/user_preferences_model.dart';

class QuickScanForm extends StatefulWidget {
  const QuickScanForm({super.key, required this.formKey, required this.index});

  final GlobalKey<FormBuilderState> formKey;

  final int index;

  @override
  State<QuickScanForm> createState() => _QuickScanForm();
}

class _QuickScanForm extends State<QuickScanForm> {
  int groupId = 0;

  @override
  initState() {
    super.initState();
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    groupId = userPreferencesModel.userPreferences.quickScanDefaultGroupId;
  }

  // TODO: refactor to a common Widget to use in receipt form
  Widget _buildGroupField(api.UserPreferences userPreferences) {
    int? initialValue = null;

    if (userPreferences.quickScanDefaultGroupId > 0) {
      initialValue = userPreferences.quickScanDefaultGroupId;
    }

    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: buildGroupDropDownMenuItems(context),
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
      onChanged: (value) {
        setState(() {
          widget.formKey.currentState!.fields["paidByUserId"]!.setValue(null);
          groupId = value as int;
        });
      },
    );
  }

  Widget _buildUserDropDown(api.UserPreferences userPreferences) {
    List<DropdownMenuItem> items = [];
    int? initialValue = null;

    if (groupId > 0) {
      items = buildGroupMemberDropDownMenuItems(context, groupId.toString());
    }

    if (groupId != 0 &&
        groupId == userPreferences.quickScanDefaultGroupId &&
        userPreferences.userId > 0) {
      initialValue = userPreferences.quickScanDefaultPaidById;
    }

    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items,
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
    );
  }

  Widget _buildStatusDropdown(api.UserPreferences userPreferences) {
    api.ReceiptStatus? initialValue = null;
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    if (userPreferencesModel.userPreferences.quickScanDefaultStatus != null) {
      initialValue =
          userPreferencesModel.userPreferences.quickScanDefaultStatus;
    }

    return FormBuilderDropdown(
      name: "status",
      decoration: const InputDecoration(labelText: "Status"),
      items: buildReceiptStatusDropDownMenuItems(),
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var userPreferences =
        Provider.of<UserPreferencesModel>(context, listen: false)
            .userPreferences;
    return FormBuilder(
        key: widget.formKey,
        child: Column(
          children: [
            textFieldSpacing,
            _buildGroupField(userPreferences),
            textFieldSpacing,
            _buildUserDropDown(userPreferences),
            textFieldSpacing,
            _buildStatusDropdown(userPreferences),
            submitButtonSpacing
          ],
        ));
  }
}
