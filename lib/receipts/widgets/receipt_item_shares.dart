// TODO: fix delete, and fix adding new items, fix broken amount owed
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_item_display.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';

import '../../interfaces/form_item.dart';
import '../../models/group_model.dart';
import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

class ReceiptItemShares extends StatefulWidget {
  const ReceiptItemShares({
    super.key,
    required this.items,
    required this.groupId,
    required this.formKey,
  });

  final List<FormItem> items;

  final int groupId;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<ReceiptItemShares> createState() => _ReceiptItemShares();
}

class _ReceiptItemShares extends State<ReceiptItemShares> {
  var indexSelected = 0;
  var expandedUserMap = <int, bool>{};
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);

  Map<int, List<FormItem>> getUserItemMap() {
    var itemMap = <int, List<FormItem>>{};
    for (var item in widget.items) {
      // Only include items that have a valid chargedToUserId (shares, not items)
      if (item.chargedToUserId != null) {
        if (itemMap.containsKey(item.chargedToUserId)) {
          itemMap[item.chargedToUserId]!.add(item);
        } else {
          itemMap[item.chargedToUserId!] = [item];
        }
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

    // Fallback display name if user not found
    var displayName = user?.displayName ?? "Unknown User (ID: $userId)";

    var owedAmount = items
        .map((item) => exchangeUSDToCustom(item.amount))
        .reduce((value, element) => value + element);

    return ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: expanded,
        headerBuilder: (context, expanded) {
          return ListTile(
            title: Text("$displayName - Amount Owed: $owedAmount"),
          );
        },
        body: Container(
          child: buildExpansionPanelBody(items),
        ));
  }

  Widget buildExpansionPanelBody(List<FormItem> items) {
    List<Widget> itemWidgets = [];
    
    for (var i = 0; i < items.length; i++) {
      var itemIndex =
          widget.items.indexWhere((item) => item.formId == items[i].formId);

      itemWidgets.add(ReceiptItemDisplay(
        item: items[i],
        displayIndex: i,
        groupId: widget.groupId,
        formKey: widget.formKey,
        formState: formState,
        groupModel: groupModel,
        onDelete: formState != WranglerFormState.view
            ? () {
                var newItems = [...widget.items];
                newItems.removeAt(itemIndex);

                setState(() {
                  receiptModel.setItems(newItems);
                });
              }
            : null,
      ));

      // Add spacing between items
      if (i < items.length - 1) {
        itemWidgets.add(const SizedBox(height: 16));
      }
    }

    if (formState != WranglerFormState.view) {
      itemWidgets.add(const SizedBox(height: 16));
      itemWidgets.add(
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              widget.formKey.currentState?.save();
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
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: itemWidgets,
      ),
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
