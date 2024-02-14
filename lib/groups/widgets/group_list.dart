import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/groups/widgets/group_list_card.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupList();
}

class _GroupList extends State<GroupList> {
  void onGroupTap(api.Group group) {
    context.go("/groups/${group.id}/dashboards");
  }

  @override
  Widget build(BuildContext context) {
    var groupProvider = Provider.of<GroupModel>(context, listen: true);

    List<Widget> buildGroupCards() {
      var widgets = <Widget>[];
      for (int i = 0; i < groupProvider.groups.length; i++) {
        widgets.add(GroupListCard(
            group: groupProvider.groups[i], onGroupTap: onGroupTap));

        if (i < groupProvider.groups.length - 1) {
          widgets.add(const Divider());
        }
      }

      return widgets;
    }

    return Expanded(child: ListView(children: buildGroupCards()));
  }
}
