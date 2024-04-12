import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_list.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/multi-select-field.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/receipt_model.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm({super.key, required this.formKey});

  final GlobalKey<FormBuilderState> formKey;

  @override
  State<ReceiptForm> createState() => _ReceiptForm();
}

class _ReceiptForm extends State<ReceiptForm> {
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;
  late final formState = getFormStateFromContext(context);
  int groupId = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ReceiptModel>(context, listen: false);

    groupId = receipt.groupId;
  }

  Widget buildNameField() {
    return FormBuilderTextField(
      name: "name",
      decoration: const InputDecoration(labelText: "Name"),
      initialValue: receipt.name,
      validator: FormBuilderValidators.required(),
      readOnly: isFieldReadOnly(formState),
    );
  }

  Widget buildAmountField() {
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

  Widget buildDateField() {
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

  Widget buildGroupField() {
    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: buildGroupDropDownMenuItems(context),
      initialValue: receipt.groupId,
      enabled: !isFieldReadOnly(formState),
      onChanged: (value) {
        setState(() {
          widget.formKey.currentState!.fields["paidByUserId"]!.setValue(null);
          groupId = value as int;
        });
      },
    );
  }

  Widget buildPaidByField() {
    List<DropdownMenuItem> items = [];
    var initialValue = null;
    if (groupId == receipt.groupId) {
      initialValue = receipt.paidByUserId;
    }

    if (groupId > 0) {
      items = buildGroupMemberDropDownMenuItems(context, groupId.toString());
    }

    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items.toList(),
      initialValue: initialValue,
      enabled: !isFieldReadOnly(formState),
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
      initialValue: receipt.status,
      enabled: !isFieldReadOnly(formState),
    );
  }

  Widget buildCategoryField() {
    return MultiSelectField<api.Category>(
      name: "categories",
      label: "Categories",
      initialValue: receipt.categories,
      itemDisplayName: (category) => category.name ?? "",
      itemName: "Categories",
    );
  }

  Widget buildTagField() {
    return MultiSelectField<api.Tag>(
      name: "tags",
      label: "Tags",
      initialValue: receipt.tags,
      itemDisplayName: (tag) => tag.name ?? "",
      itemName: "Tags",
    );
  }

  Widget buildReceiptItemList() {
    return ReceiptItemField(
        name: "items",
        label: "Shared With",
        initialValue: receipt.receiptItems);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textFieldSpacing,
          buildNameField(),
          textFieldSpacing,
          buildAmountField(),
          textFieldSpacing,
          buildDateField(),
          textFieldSpacing,
          buildGroupField(),
          textFieldSpacing,
          buildPaidByField(),
          textFieldSpacing,
          buildStatusField(),
          textFieldSpacing,
          buildCategoryField(),
          textFieldSpacing,
          buildTagField(),
          textFieldSpacing,
          buildReceiptItemList(),
          kDebugMode
              ? ElevatedButton(
                  onPressed: () => {
                        if (widget.formKey.currentState!.saveAndValidate())
                          {print(widget.formKey.currentState!.value)}
                      },
                  child: Text("Check form value"))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
