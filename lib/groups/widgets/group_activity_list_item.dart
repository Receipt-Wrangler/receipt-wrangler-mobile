import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/client/client.dart';
import 'package:receipt_wrangler_mobile/constants/font.dart';
import 'package:receipt_wrangler_mobile/shared/functions/activities.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_widget.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../../constants/colors.dart';
import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../models/user_model.dart';
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
  late final userModel = Provider.of<UserModel>(context, listen: false);
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

  Widget buildSubtitleWidget() {
    var user = userModel.getUserById(widget.activity.ranByUserId.toString());

    return Text("Ran by ${user?.displayName}");
  }

  Widget buildListTile() {
    return ListTile(
        leading: getLeadingWidget(),
        subtitle: buildSubtitleWidget(),
        title: Text(
          getActivityTypeDisplay(widget.activity.type),
          style: boldText,
        ),
        trailing: getTrailingWidget());
  }

  Widget buildSlideableAction() {
    return SlidableAction(
      icon: Icons.refresh,
      label: "Rerun Activity",
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: (BuildContext context) async {
        await rerunActivity();
      },
    );
  }

  Future<void> rerunActivity() async {
    try {
      await OpenApiClient.client
          .getSystemTaskApi()
          .rerunActivity(id: widget.activity.id);

      showSuccessSnackbar(context, "Activity has been successfully queued.");
    } catch (e) {
      print("error rerunning activity");
      print(e);
      showApiErrorSnackbar(context, e as dynamic);
    }
  }

  @override
  Widget build(BuildContext context) {
    var canEdit = canEditReceipt(authModel, groupModel, widget.groupId);
    var slideEnabled = canEdit && (widget.activity.canBeRestarted ?? false);

    return SlidableWidget(
        slideEnabled: true,
        endActionPaneChildren: [buildSlideableAction()],
        slidableChild: buildListTile());
  }
}
