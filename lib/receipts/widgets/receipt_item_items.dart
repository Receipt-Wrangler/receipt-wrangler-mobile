// TODO: fix delete, and fix adding new items, fix broken amount owed
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/functions/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/functions/status_field.dart';

import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

class ReceiptItemItems extends StatefulWidget {
  const ReceiptItemItems({
    super.key,
    required this.items,
  });

  final List<api.Item> items;

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

  @override
  didUpdateWidget(ReceiptItemItems oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length != widget.items.length) {
      for (var i = 0; i < widget.items.length; i++) {
        var item = widget.items[i];
        var itemName = "items.$i.name";
        var amountName = "items.$i.amount";
        var statusName = "items.$i.status";

        formKey.currentState?.fields[itemName]?.setValue(item.name);
        formKey.currentState?.fields[amountName]?.setValue(item.amount);
        formKey.currentState?.fields[statusName]?.setValue(item.status);
        setState(() {});
      }
    }
  }

  Map<int, List<api.Item>> getUserItemMap() {
    var itemMap = <int, List<api.Item>>{};
    for (var item in widget.items) {
      if (itemMap.containsKey(item.chargedToUserId)) {
        itemMap[item.chargedToUserId]!.add(item);
      } else {
        itemMap[item.chargedToUserId] = [item];
      }
    }

    return itemMap;
  }

  Widget buildUserExpansionList(Map<int, List<api.Item>> userItemMap) {
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

  ExpansionPanel buildExpansionPanel(int userId, List<api.Item> items) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var userIdString = userId.toString();
    var user = userModel.getUserById(userIdString);
    var expanded = expandedUserMap[userId] ?? false;
    var owedAmount = items
        .map((item) => num.parse(item.amount))
        .reduce((value, element) => value + element);

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

  Widget buildExpansionPanelBody(List<api.Item> items) {
    List<Widget> itemWidgets = [];
    for (var i = 0; i < items.length; i++) {
      itemWidgets.add(textFieldSpacing);

      var itemIndex = widget.items.indexOf(items[i]);

      itemWidgets.add(buildItemRow(items[i], itemIndex));
    }

    if (formState != WranglerFormState.view) {
      itemWidgets.add(textFieldSpacing);
      itemWidgets.add(
        ElevatedButton(
          onPressed: () {
            var newItems = [...widget.items];
            newItems.add(api.Item(
              name: "",
              amount: "0.00",
              chargedToUserId: items[0].chargedToUserId,
              receiptId: receiptModel.receipt.id,
              status: api.ItemStatus.OPEN,
            ));
            receiptModel.setItems(newItems);
          },
          child: const Text("Add Item"),
        ),
      );
    }

    return Column(
      children: itemWidgets,
    );
  }

  Widget buildItemRow(api.Item item, int index) {
    var itemName = "items.$index.name";
    var amountName = "items.$index.amount";
    var statusName = "items.$index.status";

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

    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            key: UniqueKey(),
            name: itemName,
            initialValue: initialName,
            decoration: const InputDecoration(label: Text("Name")),
            readOnly: isFieldReadOnly(formState),
          ),
        ),
        Expanded(
            child: amountField(
                key: UniqueKey(),
                context,
                "Amount",
                amountName,
                initialAmount,
                formState)),
        Expanded(
          key: UniqueKey(),
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
