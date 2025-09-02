// TODO: fix delete, and fix adding new items, fix broken amount owed
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
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
  var _linkedItemsParentMap = <FormItem, FormItem>{};
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);

  Map<int, List<FormItem>> getUserItemMap() {
    var itemMap = <int, List<FormItem>>{};
    
    // Track which items are linked items and their parent
    var linkedItemsWithParent = <FormItem, FormItem>{};
    
    // Track items that have already been processed to avoid duplicates
    var processedItemIds = <String>{};
    
    for (var item in widget.items) {
      // Process direct shares (items with chargedToUserId)
      if (item.chargedToUserId != null) {
        processedItemIds.add(item.formId);
        if (itemMap.containsKey(item.chargedToUserId)) {
          itemMap[item.chargedToUserId]!.add(item);
        } else {
          itemMap[item.chargedToUserId!] = [item];
        }
      }
      
      // Process linked items from regular items
      if (item.chargedToUserId == null && item.linkedItems.isNotEmpty) {
        for (var linkedItem in item.linkedItems) {
          if (linkedItem.chargedToUserId != null && !processedItemIds.contains(linkedItem.formId)) {
            // Only process if not already processed as a direct share
            // Store the parent-child relationship
            linkedItemsWithParent[linkedItem] = item;
            processedItemIds.add(linkedItem.formId);
            
            if (itemMap.containsKey(linkedItem.chargedToUserId)) {
              itemMap[linkedItem.chargedToUserId]!.add(linkedItem);
            } else {
              itemMap[linkedItem.chargedToUserId!] = [linkedItem];
            }
          }
        }
      }
    }
    
    // Store the linked items mapping for later use
    _linkedItemsParentMap = linkedItemsWithParent;

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
      // Check if this item is a linked item and get its parent
      var parentItem = _linkedItemsParentMap[items[i]];

      itemWidgets.add(ReceiptItemDisplay(
        item: items[i],
        displayIndex: i,
        groupId: widget.groupId,
        formKey: widget.formKey,
        formState: formState,
        groupModel: groupModel,
        parentItem: parentItem, // Pass the parent item if it exists
        onDelete: formState != WranglerFormState.view
            ? () {
                var currentItem = items[i];
                var parentItem = _linkedItemsParentMap[currentItem];
                
                if (parentItem != null) {
                  // This is a linked item - need to remove from parent's linkedItems
                  var parentIndex = widget.items.indexWhere(
                    (item) => item.formId == parentItem.formId
                  );
                  
                  if (parentIndex != -1) {
                    // Create updated parent with linkedItem removed
                    var updatedParent = FormItem(
                      formId: parentItem.formId,
                      name: parentItem.name,
                      amount: parentItem.amount,
                      chargedToUserId: parentItem.chargedToUserId,
                      receiptId: parentItem.receiptId,
                      status: parentItem.status,
                      categories: parentItem.categories,
                      tags: parentItem.tags,
                      linkedItems: parentItem.linkedItems
                          .where((linkedItem) => linkedItem.formId != currentItem.formId)
                          .toList(),
                    );
                    
                    var newItems = [...widget.items];
                    newItems[parentIndex] = updatedParent;
                    
                    setState(() {
                      receiptModel.setItems(newItems);
                    });
                  }
                } else {
                  // This is a direct share - use existing logic
                  var itemIndex = widget.items.indexWhere(
                    (item) => item.formId == currentItem.formId
                  );
                  
                  if (itemIndex != -1) {
                    var newItems = [...widget.items];
                    newItems.removeAt(itemIndex);
                    
                    setState(() {
                      receiptModel.setItems(newItems);
                    });
                  }
                }
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
