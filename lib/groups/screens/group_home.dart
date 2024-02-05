import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_app_bar.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/groups_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';

class GroupHome extends StatefulWidget {
  const GroupHome({super.key});

  @override
  State<GroupHome> createState() => _GroupHome();
}

class _GroupHome extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      appBarWidget: GroupAppBar(),
      bottomNavigationBarWidget: GroupsBottomNav(),
      children: [Text("Group Home Screen")],
    );
  }
}
