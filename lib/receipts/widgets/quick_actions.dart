import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/utils/users.dart';

import '../../models/context_model.dart';
import '../../models/group_model.dart';
import '../../models/receipt_model.dart';
import '../../shared/functions/multi_select_bottom_sheet.dart';
import '../../shared/widgets/multi-select-field.dart';

class ReceiptQuickActions extends StatefulWidget {
  const ReceiptQuickActions({super.key, required int this.groupId});

  final int groupId;

  @override
  State<ReceiptQuickActions> createState() => _ReceiptQuickActions();
}

class _ReceiptQuickActions extends State<ReceiptQuickActions> {
  late final shellContext =
      Provider.of<ContextModel>(context, listen: false).shellContext;
  late final userModel = Provider.of<UserModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).quickActionsFormKey;

  var quickActions = ["Split Evenly", "Split Evenly with Portions"];
  var quickActionsSelection = [true, false];

  Widget buildUserField() {
    return MultiSelectField<api.UserView>(
        name: "userIds",
        label: "Users",
        required: true,
        initialValue: [],
        itemDisplayName: (user) => user.displayName ?? "",
        itemName: "Users",
        onTap: showUserMultiSelect);
  }

  void showUserMultiSelect() {
    showMultiselectBottomSheet(
        shellContext,
        "Select Users",
        "Select",
        getUsersInGroup(userModel, groupModel, widget.groupId.toString()),
        [],
        (user) => user.displayName).then((value) {
      if (value != null) {
        var users =
            List<api.UserView>.from(value.map((item) => item as api.UserView));

        setState(() {
          formKey.currentState!.fields["userIds"]!.setValue(users);
        });
      }
    });
  }

  Widget buildToggleButtons() {
    return ToggleButtons(
      children: [...quickActions.map((action) => Text(action))],
      isSelected: quickActionsSelection,
      onPressed: (selected) => setState(() {
        var newState = !quickActionsSelection[selected];

        quickActionsSelection = [false, false];
        quickActionsSelection[selected] = newState;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [buildToggleButtons()],
            ),
            buildUserField(),
          ],
        ));
  }
}
