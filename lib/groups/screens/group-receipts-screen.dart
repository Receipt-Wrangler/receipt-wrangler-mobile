import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group-receipts-list.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsScreen extends StatefulWidget {
  const GroupReceiptsScreen({super.key});

  @override
  State<GroupReceiptsScreen> createState() => _GroupReceiptsScreen();
}

class _GroupReceiptsScreen extends State<GroupReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    var groupId = getGroupId(context);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var group = groupModel.getGroupById(groupId ?? "");

    return const GroupReceiptsList();
  }

  //   return ScreenWrapper(
  //       appBarWidget: TopAppBar(
  //         titleText: "${group?.name} Receipts",
  //         leadingArrowRedirect: "/groups",
  //       ),
  //       bodyPadding: EdgeInsets.zero,
  //       bottomNavigationBarWidget: const GroupDashboardBottomNav(),
  //       children: const [GroupReceiptsList()]);
  // }
}
