import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_list_card.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupList();
}

class _GroupList extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    var groupProvider = Provider.of<GroupModel>(context, listen: true);

    return Expanded(
        child: ListView(
      children: groupProvider.groups
          .map((group) => GroupListCard(group: group))
          .toList(),
    ));
  }
}
