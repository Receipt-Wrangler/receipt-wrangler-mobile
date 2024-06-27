import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_list.dart';
import 'package:receipt_wrangler_mobile/shared/functions/amountField.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/multi-select-field.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/category_model.dart';
import '../../models/context_model.dart';
import '../../models/receipt_model.dart';
import '../../models/tag_model.dart';
import '../../shared/functions/multi_select_bottom_sheet.dart';
import '../../shared/functions/status_field.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm({super.key});

  @override
  State<ReceiptForm> createState() => _ReceiptForm();
}

class _ReceiptForm extends State<ReceiptForm> {
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).receiptFormKey;
  late final formState = getFormStateFromContext(context);
  late final categoryModel = Provider.of<CategoryModel>(context, listen: false);
  late final tagModel = Provider.of<TagModel>(context, listen: false);
  late final shellContext =
      Provider.of<ContextModel>(context, listen: false).shellContext;
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
    return amountField(
        "Amount", "amount", receipt.amount.toString(), formState);
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
        validator: FormBuilderValidators.required(),
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
      validator: FormBuilderValidators.required(),
      onChanged: (value) {
        setState(() {
          formKey.currentState!.fields["paidByUserId"]!.setValue(null);
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
      validator: FormBuilderValidators.required(),
      enabled: !isFieldReadOnly(formState),
    );
  }

  Widget buildStatusField() {
    return receiptStatusField("Status", "status", receipt.status, formState);
  }

  Widget buildCategoryField() {
    return MultiSelectField<api.Category>(
        name: "categories",
        label: "Categories",
        initialValue: receipt.categories,
        itemDisplayName: (category) => category.name ?? "",
        itemName: "Categories",
        onTap: formState == WranglerFormState.view
            ? null
            : showCategoryMultiSelect);
  }

  void showCategoryMultiSelect() {
    showMultiselectBottomSheet(
        shellContext,
        "Select Categories",
        "Select",
        categoryModel.categories,
        formKey.currentState!.fields["categories"]!.value ?? receipt.categories,
        (category) => category.name).then((value) {
      if (value != null) {
        var categories =
            List<api.Category>.from(value.map((item) => item as api.Category));

        setState(() {
          formKey.currentState!.fields["categories"]!.setValue(categories);
        });
      }
    });
  }

  Widget buildTagField() {
    return MultiSelectField<api.Tag>(
        name: "tags",
        label: "Tags",
        initialValue: receipt.tags,
        itemDisplayName: (tag) => tag.name ?? "",
        itemName: "Tags",
        onTap: formState == WranglerFormState.view ? null : showTagMultiSelect);
  }

  void showTagMultiSelect() {
    showMultiselectBottomSheet(
        shellContext,
        "Select Tags",
        "Select",
        tagModel.tags,
        formKey.currentState!.fields["tags"]!.value ?? receipt.tags,
        (tag) => tag.name).then((value) {
      if (value != null) {
        var tags = List<api.Tag>.from(value.map((item) => item as api.Tag));

        setState(() {
          formKey.currentState!.fields["tags"]!.setValue(tags);
        });
      }
    });
  }

  Widget buildReceiptItemList() {
    return ReceiptItemField(
        name: "items",
        label: "Shared With",
        initialValue: receipt.receiptItems);
  }

  Widget buildHeaderText(String headerText) {
    return Text(
      headerText,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDetailsHeader() {
    return Row(
      children: [
        buildHeaderText("Details"),
      ],
    );
  }

  Widget buildSharesHeader() {
    return Row(
      children: [
        buildHeaderText("Shares"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildDetailsHeader(),
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
          buildSharesHeader(),
          textFieldSpacing,
          buildReceiptItemList(),
          textFieldSpacing,
          kDebugMode
              ? ElevatedButton(
                  onPressed: () => {
                        if (formKey.currentState!.saveAndValidate())
                          {print(formKey.currentState!.value)}
                      },
                  child: Text("Check form value"))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
