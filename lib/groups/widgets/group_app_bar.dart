import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';

class GroupAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GroupAppBar({super.key});

  @override
  State<GroupAppBar> createState() => _GroupAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _GroupAppBar extends State<GroupAppBar> {
  Widget avatarIcon() {
    var authModel = Provider.of<AuthModel>(context, listen: true);
    return CircleAvatar(
      child: Text("${authModel!.claims!.displayName[0]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Groups"),
      actions: [avatarIcon()],
      centerTitle: false,
    );
  }
}
