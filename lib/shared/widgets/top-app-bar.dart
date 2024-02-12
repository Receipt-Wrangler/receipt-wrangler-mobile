import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.titleText, this.leading});

  final String titleText;

  final Widget? leading;

  @override
  State<TopAppBar> createState() => _TopAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _TopAppBar extends State<TopAppBar> {
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
