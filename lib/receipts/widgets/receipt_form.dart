import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/users.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm(
      {super.key, required this.receipt, required this.formState});

  final api.Receipt receipt;

  final WranglerFormState formState;

  @override
  State<ReceiptForm> createState() => _ReceiptForm();
}

class _ReceiptForm extends State<ReceiptForm> {
  Widget buildDateField() {
    if (widget.formState == WranglerFormState.view) {
      var dateFormatter = DateFormat("MM/dd/yyyy");
      var formattedDate =
          dateFormatter.format(DateTime.parse(widget.receipt.date));
      return FormBuilderTextField(
          name: "date",
          decoration: const InputDecoration(labelText: "Date"),
          initialValue: formattedDate,
          readOnly: true);
    } else {
      return FormBuilderDateTimePicker(
        name: "date",
        decoration: const InputDecoration(labelText: "Date"),
        initialValue: DateTime.parse(widget.receipt.date),
        inputType: InputType.date,
      );
    }
  }

  Widget buildGroupField() {
    var groupModel = Provider.of<GroupModel>(context, listen: false);

    var items = groupModel.groups.map((group) => DropdownMenuItem(
          value: group.id,
          child: Text(group.name),
        ));
    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: items.toList(),
      initialValue: widget.receipt.groupId,
      enabled: !isFieldReadOnly(widget.formState),
    );
  }

  Widget buildPaidByField() {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var groupId = widget.receipt.groupId.toString();

    var items = getUsersInGroup(userModel, groupModel, groupId)
        .map((user) => DropdownMenuItem(
              value: user.id,
              child: Text(user.displayName),
            ));
    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items.toList(),
      initialValue: widget.receipt.paidByUserId,
      enabled: !isFieldReadOnly(widget.formState),
    );
  }

  Widget buildStatusField() {
    return FormBuilderDropdown(
      name: "status",
      decoration: const InputDecoration(labelText: "Status"),
      items: const [
        DropdownMenuItem(
          value: api.ReceiptStatus.OPEN,
          child: Text("Open"),
        ),
        DropdownMenuItem(
          value: api.ReceiptStatus.NEEDS_ATTENTION,
          child: Text("Needs Attention"),
        ),
        DropdownMenuItem(
          value: api.ReceiptStatus.RESOLVED,
          child: Text("Resolved"),
        ),
        DropdownMenuItem(
          value: api.ReceiptStatus.DRAFT,
          child: Text("Draft"),
        ),
      ],
      initialValue: widget.receipt.status,
      enabled: !isFieldReadOnly(widget.formState),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.receipt.date);
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormBuilderTextField(
            name: "name",
            decoration: const InputDecoration(labelText: "Name"),
            initialValue: widget.receipt.name,
            validator: FormBuilderValidators.required(),
            readOnly: isFieldReadOnly(widget.formState),
          ),
          textFieldSpacing,
          FormBuilderTextField(
            name: "amount",
            decoration: const InputDecoration(labelText: "Amount"),
            initialValue: widget.receipt.amount.toString(),
            validator: FormBuilderValidators.required(),
            readOnly: isFieldReadOnly(widget.formState),
          ),
          textFieldSpacing,
          buildDateField(),
          textFieldSpacing,
          buildGroupField(),
          textFieldSpacing,
          buildPaidByField(),
          textFieldSpacing,
          buildStatusField(),
          textFieldSpacing,
        ],
      ),
    );
  }
}
