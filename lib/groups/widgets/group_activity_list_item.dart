import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/shared/functions/activities.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/date_block.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_widget.dart';

import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../shared/functions/permissions.dart';

class GroupActivityListItem extends StatefulWidget {
  const GroupActivityListItem(
      {super.key, required this.activity, required this.groupId});

  final api.Activity activity;

  final int groupId;

  @override
  State<GroupActivityListItem> createState() => _GroupActivityListItem();
}

class _GroupActivityListItem extends State<GroupActivityListItem> {
  late final authModel = Provider.of<AuthModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);

  Widget buildListTile() {
    return ListTile(
      leading: DateBlock(date: widget.activity.startedAt),
      title: Text(getActivityTypeDisplay(widget.activity.type)),
      trailing: Text(getActivityStatusDisplay(widget.activity.status)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var canEdit = canEditReceipt(authModel, groupModel, widget.groupId);

    return SlidableWidget(
        slideEnabled: canEdit,
        endActionPaneChildren: [],
        slidableChild: buildListTile());
  }
}
