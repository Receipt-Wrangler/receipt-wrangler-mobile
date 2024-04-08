import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_list.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/multi-select-field.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/users.dart';

import '../../models/receipt_model.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm({super.key});

  @override
  State<ReceiptForm> createState() => _ReceiptForm();
}

class _ReceiptForm extends State<ReceiptForm> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReceiptModel>(context, listen: false);
  }

  Widget buildAmountField(api.Receipt receipt, WranglerFormState formState) {
    var amountMask = new CurrencyTextInputFormatter(
        decimalDigits: 2, enableNegative: false, symbol: "");
    return FormBuilderTextField(
      name: "amount",
      decoration: const InputDecoration(labelText: "Amount", prefixText: "\$ "),
      keyboardType: TextInputType.number,
      initialValue: receipt.amount.toString(),
      validator: FormBuilderValidators.required(),
      readOnly: isFieldReadOnly(formState),
      inputFormatters: [amountMask],
    );
  }

  Widget buildDateField(api.Receipt receipt, WranglerFormState formState) {
    if (formState == WranglerFormState.view) {
      var formattedDate =
          formatDate(defaultDateFormat, DateTime.parse(receipt.date));
      return FormBuilderTextField(
          name: "date",
          decoration: const InputDecoration(labelText: "Date"),
          initialValue: formattedDate,
          readOnly: true);
    } else {
      return FormBuilderDateTimePicker(
        name: "date",
        decoration: const InputDecoration(labelText: "Date"),
        initialValue: DateTime.parse(receipt.date),
        inputType: InputType.date,
      );
    }
  }

  Widget buildGroupField(api.Receipt receipt, WranglerFormState formState) {
    var groupModel = Provider.of<GroupModel>(context, listen: false);

    var items = groupModel.groups.map((group) => DropdownMenuItem(
          value: group.id,
          child: Text(group.name),
        ));
    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: items.toList(),
      initialValue: receipt.groupId,
      enabled: !isFieldReadOnly(formState),
    );
  }

  Widget buildPaidByField(api.Receipt receipt, WranglerFormState formState) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var groupId = receipt.groupId.toString();

    var items = getUsersInGroup(userModel, groupModel, groupId)
        .map((user) => DropdownMenuItem(
              value: user.id,
              child: Text(user.displayName),
            ));
    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items.toList(),
      initialValue: receipt.paidByUserId,
      enabled: !isFieldReadOnly(formState),
    );
  }

  Widget buildStatusField(api.Receipt receipt, WranglerFormState formState) {
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
      initialValue: receipt.status,
      enabled: !isFieldReadOnly(formState),
    );
  }

  Widget buildCategoryField(api.Receipt receipt) {
    return MultiSelectField<api.Category>(
      name: "categories",
      label: "Categories",
      initialValue: receipt.categories,
      itemDisplayName: (category) => category.name ?? "",
      itemName: "Categories",
    );
  }

  Widget buildTagField(api.Receipt receipt) {
    return MultiSelectField<api.Tag>(
      name: "tags",
      label: "Tags",
      initialValue: receipt.tags,
      itemDisplayName: (tag) => tag.name ?? "",
      itemName: "Tags",
    );
  }

  Widget buildReceiptItemList(api.Receipt receipt) {
    return ReceiptItemField(
        name: "receiptItems",
        label: "Shared With",
        initialValue: receipt.receiptItems);
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
    var uri = GoRouterState.of(context).uri;
    var formState = getFormState(uri.toString());

    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textFieldSpacing,
          FormBuilderTextField(
            name: "name",
            decoration: const InputDecoration(labelText: "Name"),
            initialValue: receipt.name,
            validator: FormBuilderValidators.required(),
            readOnly: isFieldReadOnly(formState),
          ),
          textFieldSpacing,
          buildAmountField(receipt, formState),
          textFieldSpacing,
          buildDateField(receipt, formState),
          textFieldSpacing,
          buildGroupField(receipt, formState),
          textFieldSpacing,
          buildPaidByField(receipt, formState),
          textFieldSpacing,
          buildStatusField(receipt, formState),
          textFieldSpacing,
          buildCategoryField(receipt),
          textFieldSpacing,
          buildTagField(receipt),
          textFieldSpacing,
          buildReceiptItemList(receipt),
          kDebugMode
              ? ElevatedButton(
                  onPressed: () => {
                        if (_formKey.currentState!.saveAndValidate())
                          {print(_formKey.currentState!.value)}
                      },
                  child: Text("Check form value"))
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
