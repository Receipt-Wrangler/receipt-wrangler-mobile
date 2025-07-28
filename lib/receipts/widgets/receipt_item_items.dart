import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/shared/functions/status_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/category_select_field.dart';

import '../../interfaces/form_item.dart';
import '../../models/group_model.dart';
import '../../models/receipt_model.dart';
import '../../shared/widgets/tag_select_field.dart';
import '../../utils/forms.dart';

class ReceiptItemItems extends StatefulWidget {
  const ReceiptItemItems({
    super.key,
    required this.groupId,
  });

  final int groupId;

  @override
  State<ReceiptItemItems> createState() => _ReceiptItemItems();
}

class _ReceiptItemItems extends State<ReceiptItemItems> {
  bool isExpanded = false;
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).receiptFormKey;

  List<FormItem> getItems(List<FormItem> items) {
    return items.where((item) => item.chargedToUserId == null).toList();
  }

  Widget buildSingleExpansionPanel(List<FormItem> items) {
    var expansionList = ExpansionPanelList(
      expansionCallback: (int index, bool expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpanded,
          headerBuilder: (context, expanded) {
            return ListTile(
              title: Text("Items (${items.length})"),
              subtitle: items.isNotEmpty 
                  ? Text("Total items: ${items.length}")
                  : Text("No items added"),
            );
          },
          body: buildItemsList(items),
        ),
      ],
    );

    return expansionList;
  }

  Widget buildItemsList(List<FormItem> items) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          "No items added yet. Use the 'Add Item' button above to add items.",
          style: TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      );
    }

    List<Widget> itemWidgets = [];
    
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      
      itemWidgets.add(buildItemCard(item, i));
      
      // Add spacing between items except for the last one
      if (i < items.length - 1) {
        itemWidgets.add(const SizedBox(height: 16));
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: itemWidgets,
      ),
    );
  }

  Widget buildItemCard(FormItem item, int displayIndex) {
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
            buildItemRow(item, displayIndex),
            if (formState != WranglerFormState.view) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    var allItems = receiptModel.items;
                    var actualIndex = allItems.indexWhere((wi) => wi.formId == item.formId);
                    if (actualIndex != -1) {
                      var newItems = [...allItems];
                      newItems.removeAt(actualIndex);

                      setState(() {
                        receiptModel.setItems(newItems);
                      });
                    }
                  },
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

  Widget buildItemRow(FormItem item, int index) {
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
    var initialTags = formKey.currentState?.fields[tagName]?.value ?? item.tags;

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
                    formState: formState)),
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
                  .getGroupReceiptSettings(widget.groupId)
                  ?.hideItemCategories ==
              false,
          child: CategorySelectField(
              label: "Categories",
              fieldName: categoryName,
              initialCategories: initialCategories,
              formState: formState,
              onCategoriesChanged: (categories) {
                setState(() {
                  formKey.currentState?.fields[categoryName]
                      ?.setValue(categories);
                });
              }),
        ),
        Visibility(
            visible: groupModel
                    .getGroupReceiptSettings(widget.groupId)
                    ?.hideItemTags ==
                false,
            child: TagSelectField(
                label: "Tags",
                fieldName: tagName,
                initialTags: initialTags,
                formState: formState,
                onTagsChanged: (tags) {
                  setState(() {
                    formKey.currentState?.fields[tagName]?.setValue(tags);
                  });
                }))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptModel>(
      builder: (context, consumerModel, child) {
        var items = getItems(consumerModel.items);

        if (items.isEmpty) {
          return const Text("No items found");
        }

        return buildSingleExpansionPanel(items);
      },
    );
  }
}