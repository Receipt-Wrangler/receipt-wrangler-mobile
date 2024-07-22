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
  late final modifiedReceipt =
      Provider.of<ReceiptModel>(context, listen: false).modifiedReceipt;
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).receiptFormKey;
  late final formState = getFormStateFromContext(context);
  late final categoryModel = Provider.of<CategoryModel>(context, listen: false);
  late final tagModel = Provider.of<TagModel>(context, listen: false);
  late final shellContext =
      Provider.of<ContextModel>(context, listen: false).shellContext;
  final addSharesFormKey = GlobalKey<FormBuilderState>();
  int groupId = 0;
  bool isAddingShare = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ReceiptModel>(context, listen: false);

    groupId = modifiedReceipt.groupId;
  }

  Widget buildNameField() {
    return FormBuilderTextField(
      name: "name",
      decoration: const InputDecoration(labelText: "Name"),
      initialValue: modifiedReceipt.name,
      validator: FormBuilderValidators.required(),
      readOnly: isFieldReadOnly(formState),
    );
  }

  Widget buildAmountField() {
    return amountField(
        "Amount", "amount", modifiedReceipt.amount.toString(), formState);
  }

  Widget buildDateField() {
    if (formState == WranglerFormState.view) {
      var formattedDate =
          formatDate(defaultDateFormat, DateTime.parse(modifiedReceipt.date));
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
        initialValue: DateTime.parse(modifiedReceipt.date),
        inputType: InputType.date,
      );
    }
  }

  Widget buildGroupField() {
    int? initialValue = modifiedReceipt.groupId;
    if (formState == WranglerFormState.add && initialValue == 0) {
      initialValue = null;
    }

    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      items: buildGroupDropDownMenuItems(context),
      initialValue: initialValue,
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
    if (groupId == modifiedReceipt.groupId) {
      initialValue = modifiedReceipt.paidByUserId;
    }

    if (groupId > 0) {
      items = buildGroupMemberDropDownMenuItems(context, groupId.toString());
    }

    if (formState == WranglerFormState.add && initialValue == 0) {
      initialValue = null;
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
    return receiptStatusField(
        "Status", "status", modifiedReceipt.status, formState);
  }

  Widget buildCategoryField() {
    return MultiSelectField<api.Category>(
        name: "categories",
        label: "Categories",
        initialValue: modifiedReceipt.categories,
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
        formKey.currentState!.fields["categories"]!.value ??
            modifiedReceipt.categories,
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
        initialValue: modifiedReceipt.tags,
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
        formKey.currentState!.fields["tags"]!.value ?? modifiedReceipt.tags,
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
    return Consumer<ReceiptModel>(
      builder: (context, consumerModel, child) {
        return ReceiptItemField(
            name: "items",
            label: "Shared With",
            initialValue: consumerModel.items);
      },
    );
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
    var rowChildren = [
      buildHeaderText("Shares"),
    ];

    if (formState != WranglerFormState.view) {
      rowChildren.add(Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
            onPressed: (isAddingShare || groupId == 0)
                ? null
                : () {
                    setState(() {
                      isAddingShare = true;
                    });
                  },
          )
        ],
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...rowChildren,
      ],
    );
  }

  Widget buildAddSharesCard() {
    if (isAddingShare) {
      return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
                Text(
                  "Add Share",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ]),
              textFieldSpacing,
              FormBuilder(
                key: addSharesFormKey,
                child: Column(
                  children: [
                    FormBuilderDropdown(
                      name: "chargedToUserId",
                      decoration:
                          const InputDecoration(labelText: "Shared With"),
                      items: buildGroupMemberDropDownMenuItems(
                          context, groupId.toString()),
                      initialValue: "",
                      validator: FormBuilderValidators.required(),
                      enabled: !isFieldReadOnly(formState),
                    ),
                    textFieldSpacing,
                    FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(labelText: "Name"),
                      validator: FormBuilderValidators.required(),
                    ),
                    textFieldSpacing,
                    amountField("Amount", "amount", "", formState),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Add Share"),
                            onPressed: () {
                              if (!addSharesFormKey.currentState!
                                  .saveAndValidate()) {
                                return;
                              }

                              var items = [...receiptModel.items];
                              items.add(api.Item(
                                name: addSharesFormKey
                                    .currentState!.fields["name"]!.value,
                                amount: addSharesFormKey
                                    .currentState!.fields["amount"]!.value,
                                chargedToUserId: addSharesFormKey.currentState!
                                    .fields["chargedToUserId"]!.value,
                                receiptId: receipt?.id ?? 0,
                                status: api.ItemStatus.OPEN,
                              ));

                              receiptModel.setItems(items);
                              setState(() {
                                isAddingShare = false;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              setState(() {
                                isAddingShare = false;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
              // user field,
              // item name
              // amount field,
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
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
          buildAddSharesCard(),
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
