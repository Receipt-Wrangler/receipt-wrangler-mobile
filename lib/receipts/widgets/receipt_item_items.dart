import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_item_display.dart';

import '../../interfaces/form_item.dart';
import '../../models/group_model.dart';
import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

class ReceiptItemItems extends StatefulWidget {
  const ReceiptItemItems({
    super.key,
    required this.groupId,
    required this.formKey,
    this.forceExpanded = false,
    this.onItemSplit,
  });

  final int groupId;
  final GlobalKey<FormBuilderState> formKey;
  final bool forceExpanded;
  final Function(FormItem)? onItemSplit;

  @override
  State<ReceiptItemItems> createState() => _ReceiptItemItems();
}

class _ReceiptItemItems extends State<ReceiptItemItems> {
  bool isExpanded = false;
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);

  @override
  void didUpdateWidget(ReceiptItemItems oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forceExpanded && !oldWidget.forceExpanded) {
      setState(() {
        isExpanded = true;
      });
    }
  }

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

      itemWidgets.add(ReceiptItemDisplay(
        item: item,
        displayIndex: i,
        groupId: widget.groupId,
        formKey: widget.formKey,
        formState: formState,
        groupModel: groupModel,
        onDelete: () {
          var allItems = receiptModel.items;
          var actualIndex =
              allItems.indexWhere((wi) => wi.formId == item.formId);
          if (actualIndex != -1) {
            var newItems = [...allItems];
            newItems.removeAt(actualIndex);

            setState(() {
              receiptModel.setItems(newItems);
            });
          }
        },
        onSplit: widget.onItemSplit != null ? () => widget.onItemSplit!(item) : null,
      ));

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
