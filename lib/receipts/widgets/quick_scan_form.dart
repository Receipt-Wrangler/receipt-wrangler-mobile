import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/shared/classes/quick_scan_image.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/user_preferences_model.dart';

class QuickScanForm extends StatefulWidget {
  const QuickScanForm(
      {super.key,
      required this.formKey,
      required this.image,
      required this.index,
      required this.onDisposeCallback});

  final GlobalKey<FormBuilderState> formKey;

  final QuickScanImage image;

  final int index;

  final void Function(int?, int?, api.ReceiptStatus?) onDisposeCallback;

  @override
  State<QuickScanForm> createState() => _QuickScanForm();
}

class _QuickScanForm extends State<QuickScanForm> {
  late final userPreferences =
      Provider.of<UserPreferencesModel>(context, listen: false).userPreferences;
  int groupId = 0;

  @override
  initState() {
    super.initState();
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    groupId = widget.image.groupId ??
        userPreferencesModel.userPreferences.quickScanDefaultGroupId ??
        0;
  }

  @override
  deactivate() {
    widget.formKey.currentState!.save();
    var formValue = widget.formKey.currentState!.value;

    widget.onDisposeCallback(
        formValue["groupId"], formValue["paidByUserId"], formValue["status"]);

    super.deactivate();
  }

  // TODO: refactor to a common Widget to use in receipt form
  Widget _buildGroupField() {
    // Get the list of groups for dropdown
    final dropdownItems = buildGroupDropDownMenuItems(context);

    int? initialValue = widget.image.groupId;
    if (initialValue == null &&
        (userPreferences.quickScanDefaultGroupId ?? 0) > 0) {
      // Make sure initialValue exists in the dropdown items
      final exists = dropdownItems
          .any((item) => item.value == userPreferences.quickScanDefaultGroupId);
      if (exists) {
        initialValue = userPreferences.quickScanDefaultGroupId;
      }
    }

    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: dropdownItems,
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

  Widget _buildUserDropDown() {
    List<DropdownMenuItem> items = [];
    int? initialValue = widget.image.paidByUserId;

    if (groupId > 0) {
      items = buildGroupMemberDropDownMenuItems(context, groupId.toString());

      // Only set initialValue if the group matches and paid by ID exists
      if (initialValue == null &&
          groupId == userPreferences.quickScanDefaultGroupId &&
          userPreferences.quickScanDefaultPaidById != null) {
        // Check if the initialValue exists in the items
        final exists = items.any(
            (item) => item.value == userPreferences.quickScanDefaultPaidById);
        if (exists) {
          initialValue = userPreferences.quickScanDefaultPaidById;
        }
      }
    }

    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items,
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
    );
  }

  Widget _buildStatusDropdown() {
    api.ReceiptStatus? initialValue = widget.image.status;
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    if (initialValue == null &&
        userPreferencesModel.userPreferences.quickScanDefaultStatus != null) {
      // Make sure the status is one of the valid options
      final statusOptions = buildReceiptStatusDropDownMenuItems();
      final exists = statusOptions.any((item) =>
          item.value ==
          userPreferencesModel.userPreferences.quickScanDefaultStatus);

      if (exists) {
        initialValue =
            userPreferencesModel.userPreferences.quickScanDefaultStatus;
      }
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
    return FormBuilder(
        key: widget.formKey,
        child: Column(
          children: [
            textFieldSpacing,
            _buildGroupField(),
            textFieldSpacing,
            _buildUserDropDown(),
            textFieldSpacing,
            _buildStatusDropdown(),
            submitButtonSpacing
          ],
        ));
  }
}
