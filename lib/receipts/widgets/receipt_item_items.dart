// TODO: fix delete, and fix adding new items, fix broken amount owed
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:money2/money2.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/functions/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/functions/status_field.dart';

import '../../interfaces/form_item.dart';
import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

class ReceiptItemItems extends StatefulWidget {
  const ReceiptItemItems({
    super.key,
    required this.items,
  });

  final List<FormItem> items;

  @override
  State<ReceiptItemItems> createState() => _ReceiptItemItems();
}

class _ReceiptItemItems extends State<ReceiptItemItems> {
  var indexSelected = 0;
  var expandedUserMap = <int, bool>{};
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).receiptFormKey;

  Map<int, List<FormItem>> getUserItemMap() {
    var itemMap = <int, List<FormItem>>{};
    for (var item in widget.items) {
      if (itemMap.containsKey(item.chargedToUserId)) {
        itemMap[item.chargedToUserId]!.add(item);
      } else {
        itemMap[item.chargedToUserId] = [item];
      }
    }

    return itemMap;
  }

  Widget buildUserExpansionList(Map<int, List<FormItem>> userItemMap) {
    var expansionList = ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          // TODO: could probably be simplified by using index instead of user id in map
          var userId = userItemMap.keys.elementAt(index);
          expandedUserMap[userId] = isExpanded;
        });
      },
      children: userItemMap.entries
          .map((e) => buildExpansionPanel(e.key, e.value))
          .toList(),
    );

    return expansionList;
  }

  ExpansionPanel buildExpansionPanel(int userId, List<FormItem> items) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var userIdString = userId.toString();
    var user = userModel.getUserById(userIdString);
    var expanded = expandedUserMap[userId] ?? false;

    var owedAmount = items
        .map((item) => Money.parse(item.amount, isoCode: "USD"))
        .reduce((value, element) => value + element)
        .amount;

    return ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: expanded,
        headerBuilder: (context, expanded) {
          return ListTile(
            title: Text("${user?.displayName} - Amount Owed: ${owedAmount}"),
          );
        },
        body: Container(
          child: buildExpansionPanelBody(items),
        ));
  }

  Widget buildExpansionPanelBody(List<FormItem> items) {
    List<Widget> itemWidgets = [];
    for (var i = 0; i < items.length; i++) {
      itemWidgets.add(textFieldSpacing);

      var itemIndex =
          widget.items.indexWhere((item) => item.formId == items[i].formId);

      itemWidgets.add(buildItemRow(items[i], itemIndex));
    }

    if (formState != WranglerFormState.view) {
      itemWidgets.add(textFieldSpacing);
      itemWidgets.add(
        ElevatedButton(
          onPressed: () {
            formKey.currentState?.save();
            var newItems = [...widget.items];
            var newItem = (api.ItemBuilder()
                  ..name = ""
                  ..amount = "0.00"
                  ..chargedToUserId = items[0].chargedToUserId
                  ..receiptId = receiptModel.receipt.id
                  ..status = api.ItemStatus.OPEN)
                .build();
            newItems.add(FormItem.fromItem(newItem));

            setState(() {
              receiptModel.setItems(newItems);
            });
          },
          child: const Text("Add Share"),
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

    var initialName =
        formKey.currentState?.fields[itemName]?.value ?? item.name;
    var initialAmount =
        formKey.currentState?.fields[amountName]?.value ?? item.amount;
    var initialStatus =
        formKey.currentState?.fields[statusName]?.value ?? item.status;

    Widget iconButton = SizedBox.shrink();
    if (!isFieldReadOnly(formState)) {
      iconButton = IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            var newItems = [...widget.items];
            newItems.removeAt(index);

            setState(() {
              receiptModel.setItems(newItems);
            });
          });
    }
    // TODO: need to fix new item data being wiped out when adding
    return Row(
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
        Expanded(
            key: Key(amountName),
            child: AmountField(
                label: "Amount",
                fieldName: amountName,
                initialAmount: initialAmount,
                formState: formState)),
        Expanded(
          key: Key(statusName),
          child: itemStatusField(
            "Status",
            statusName,
            initialStatus,
            formState,
          ),
        ),
        iconButton
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userItemMap = getUserItemMap();

    if (userItemMap.isEmpty) {
      return const Text("No shares found");
    }

    return buildUserExpansionList(userItemMap);
  }
}
