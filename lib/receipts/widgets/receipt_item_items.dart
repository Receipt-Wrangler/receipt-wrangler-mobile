import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/functions/amountField.dart';
import 'package:receipt_wrangler_mobile/shared/functions/status_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

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

  List<Widget> buildSummaryTiles(Map<int, List<api.Item>> userItemMap) {
    var tiles = List<Widget>.empty(growable: true);
    var userModel = Provider.of<UserModel>(context, listen: false);

    for (var element in userItemMap.entries) {
      var totalOwed = element.value
          .map((item) => num.parse(item.amount))
          .reduce((value, element) => value + element);

      var userId = element.key.toString();
      var user = userModel.getUserById(userId);

      var tile = ListTile(
        title: Text(user?.displayName ?? ""),
        subtitle: Text("Total Owed: $totalOwed"),
        leading: UserAvatar(userId: userId),
      );
      tiles.add(tile);
    }

    return tiles;
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
      itemWidgets.add(buildItemRow(items[i], i));
    }

    return Column(
      children: itemWidgets,
    );
  }

  Widget buildItemRow(api.Item item, int index) {
    var itemName = "items.$index.name";
    var amountName = "items.$index.amount";
    var statusName = "items.$index.status";

    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            name: itemName,
            initialValue: item.name,
            decoration: const InputDecoration(label: Text("Name")),
            readOnly: isFieldReadOnly(formState),
          ),
        ),
        Expanded(
            child: amountField("Amount", amountName, item.amount, formState)),
        Expanded(
          child: itemStatusField("Status", statusName, item.status, formState),
        )
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
