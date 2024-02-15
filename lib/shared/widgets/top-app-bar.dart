import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar(
      {super.key, required this.titleText, this.leadingArrowRedirect});

  final String titleText;

  final String? leadingArrowRedirect;

  @override
  State<TopAppBar> createState() => _TopAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _TopAppBar extends State<TopAppBar> {
  Widget? getIconButton() {
    if (widget.leadingArrowRedirect != null) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go(widget.leadingArrowRedirect ?? "/");
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: getIconButton(),
      title: Text(
        widget.titleText,
      ),
      actions: const [UserAvatar()],
      centerTitle: false,
    );
  }
}
