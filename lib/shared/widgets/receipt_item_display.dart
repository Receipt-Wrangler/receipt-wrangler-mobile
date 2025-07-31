import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/shared/functions/status_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/category_select_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/tag_select_field.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../interfaces/form_item.dart';
import '../../models/group_model.dart';

class ReceiptItemDisplay extends StatelessWidget {
  const ReceiptItemDisplay({
    super.key,
    required this.item,
    required this.displayIndex,
    required this.groupId,
    required this.formKey,
    required this.formState,
    required this.groupModel,
    this.onDelete,
  });

  final FormItem item;
  final int displayIndex;
  final int groupId;
  final GlobalKey<FormBuilderState> formKey;
  final WranglerFormState formState;
  final GroupModel groupModel;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name.isEmpty ? "Unnamed Item" : item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  item.amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildItemFields(),
            if (formState != WranglerFormState.view && onDelete != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Delete Item"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItemFields() {
    var itemName = FormItem.buildItemNameName(item);
    var amountName = FormItem.buildItemAmountName(item);
    var statusName = FormItem.buildItemStatusName(item);
    var categoryName = FormItem.buildItemCategoryName(item);
    var tagName = FormItem.buildItemTagName(item);

    var initialName =
        formKey.currentState?.fields[itemName]?.value ?? item.name;
    var initialAmount =
        formKey.currentState?.fields[amountName]?.value ?? item.amount;
    var initialStatus =
        formKey.currentState?.fields[statusName]?.value ?? item.status;
    var initialCategories =
        formKey.currentState?.fields[categoryName]?.value ?? item.categories;
    var initialTags =
        formKey.currentState?.fields[tagName]?.value ?? item.tags;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              key: Key(itemName),
              child: FormBuilderTextField(
                name: itemName,
                initialValue: initialName,
                decoration: const InputDecoration(label: Text("Name")),
                readOnly: isFieldReadOnly(formState),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              key: Key(amountName),
              child: AmountField(
                label: "Amount",
                fieldName: amountName,
                initialAmount: initialAmount,
                formState: formState,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              key: Key(statusName),
              child: itemStatusField(
                "Status",
                statusName,
                initialStatus,
                formState,
              ),
            ),
          ],
        ),
        textFieldSpacing,
        Visibility(
          visible: groupModel
                  .getGroupReceiptSettings(groupId)
                  ?.hideItemCategories ==
              false,
          child: CategorySelectField(
            label: "Categories",
            fieldName: categoryName,
            initialCategories: initialCategories,
            formState: formState,
            onCategoriesChanged: (categories) {
              formKey.currentState?.fields[categoryName]?.setValue(categories);
            },
          ),
        ),
        Visibility(
          visible:
              groupModel.getGroupReceiptSettings(groupId)?.hideItemTags ==
              false,
          child: TagSelectField(
            label: "Tags",
            fieldName: tagName,
            initialTags: initialTags,
            formState: formState,
            onTagsChanged: (tags) {
              formKey.currentState?.fields[tagName]?.setValue(tags);
            },
          ),
        ),
      ],
    );
  }
}