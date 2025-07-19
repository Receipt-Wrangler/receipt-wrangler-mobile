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
    required this.items,
    required this.groupId,
  });

  final List<FormItem> items;
  final int groupId;

  @override
  State<ReceiptItemItems> createState() => _ReceiptItemItems();
}

class _ReceiptItemItems extends State<ReceiptItemItems> {
  var expandedItemMap = <String, bool>{};
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).receiptFormKey;

  List<FormItem> getItems() {
    return widget.items.where((item) => item.chargedToUserId == null).toList();
  }

  Widget buildItemExpansionList(List<FormItem> items) {
    var expansionList = ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          var item = items[index];
          expandedItemMap[item.formId] = isExpanded;
        });
      },
      children: items
          .map((item) => buildExpansionPanel(item, items.indexOf(item)))
          .toList(),
    );

    return expansionList;
  }

  ExpansionPanel buildExpansionPanel(FormItem item, int itemIndex) {
    var expanded = expandedItemMap[item.formId] ?? false;

    return ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: expanded,
        headerBuilder: (context, expanded) {
          return ListTile(
            title: Text(item.name.isEmpty ? "Unnamed Item" : item.name),
            subtitle: Text("Amount: ${item.amount}"),
          );
        },
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: buildExpansionPanelBody(item, itemIndex),
        ));
  }

  Widget buildExpansionPanelBody(FormItem item, int itemIndex) {
    List<Widget> itemWidgets = [];

    var actualIndex = widget.items.indexWhere((i) => i.formId == item.formId);
    itemWidgets.add(buildItemRow(item, actualIndex));

    if (formState != WranglerFormState.view) {
      itemWidgets.add(textFieldSpacing);
      itemWidgets.add(
        ElevatedButton(
          onPressed: () {
            var newItems = [...widget.items];
            newItems.removeAt(actualIndex);

            setState(() {
              receiptModel.setItems(newItems);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text("Delete Item"),
        ),
      );
    }

    return Column(
      children: itemWidgets,
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
    var items = getItems();

    if (items.isEmpty) {
      return const Text("No items found");
    }

    return buildItemExpansionList(items);
  }
}