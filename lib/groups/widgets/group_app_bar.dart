import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

class GroupAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GroupAppBar({super.key, required this.titleText, this.leading});

  final String titleText;

  final Widget? leading;

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
      leading: widget.leading,
      title: Text(widget.titleText),
      actions: const [UserAvatar()],
      centerTitle: false,
    );
  }
}
