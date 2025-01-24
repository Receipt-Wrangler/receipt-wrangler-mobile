import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/shared/functions/activities.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_widget.dart';

import '../../constants/colors.dart';
import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../shared/functions/permissions.dart';
import '../../shared/widgets/list_item_lead.dart';
import '../../shared/widgets/list_item_trailing_status.dart';

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

  Color getActivityColor() {
    switch (widget.activity.status) {
      case api.SystemTaskStatus.SUCCEEDED:
        return successGreen;
      case api.SystemTaskStatus.FAILED:
        return errorRed;
      default:
        return Colors.grey;
    }
  }

  Widget getLeadingWidget() {
    return ListItemLead(
      date: widget.activity.startedAt,
      color: getActivityColor(),
    );
  }

  Widget getTrailingWidget() {
    return ListItemTrailingStatus(
        color: getActivityColor(),
        text: getActivityStatusDisplay(widget.activity.status));
  }

  Widget buildListTile() {
    return ListTile(
        leading: getLeadingWidget(),
        title: Text(getActivityTypeDisplay(widget.activity.type)),
        trailing: getTrailingWidget());
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
