import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

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
    return ExpansionPanelList(
      children: userItemMap.entries
          .map((e) => buildExpansionPanel(e.key, e.value))
          .toList(),
    );
  }

  ExpansionPanel buildExpansionPanel(int userId, List<api.Item> items) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var userIdString = userId.toString();
    var user = userModel.getUserById(userIdString);

    return ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (context, expanded) {
          return ListTile(
            title: Text("${user?.displayName} - Owes: 0"),
          );
        },
        body: Text("hello body"));
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
