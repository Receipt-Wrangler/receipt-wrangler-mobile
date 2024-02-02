import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_app_bar.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_list.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/groups_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';

class GroupSelect extends StatefulWidget {
  const GroupSelect({super.key});

  @override
  State<GroupSelect> createState() => _GroupSelect();
}

class _GroupSelect extends State<GroupSelect> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      appBarWidget: GroupAppBar(),
      bottomNavigationBarWidget: GroupsBottomNav(),
      children: [GroupList()],
    );
  }
}
