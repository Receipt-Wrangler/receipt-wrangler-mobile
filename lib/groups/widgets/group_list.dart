import 'package:flutter/material.dart';
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

    List<Widget> buildGroupCards() {
      var widgets = <Widget>[];
      for (int i = 0; i < groupProvider.groups.length; i++) {
        widgets.add(GroupListCard(group: groupProvider.groups[i]));

        if (i < groupProvider.groups.length - 1) {
          widgets.add(const Divider());
        }
      }

      return widgets;
    }

    return Expanded(child: ListView(children: buildGroupCards()));
  }
}
