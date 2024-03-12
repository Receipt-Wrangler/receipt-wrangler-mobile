import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar(
      {super.key,
      required this.titleText,
      this.leadingArrowRedirect,
      this.leadingArrowExtra,
      this.actions,
      this.hideAvatar,
      this.surfaceTintColor});

  final String titleText;

  final String? leadingArrowRedirect;

  final dynamic leadingArrowExtra;

  final List<Widget>? actions;

  final bool? hideAvatar;

  final Color? surfaceTintColor;

  @override
  State<TopAppBar> createState() => _TopAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _TopAppBar extends State<TopAppBar> {
  Future<void> _logout() async {
    AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    try {
      var refreshToken = await authModel.getRefreshToken();
      await api.AuthApi().logout(
          logoutCommand: api.LogoutCommand(refreshToken: refreshToken ?? ""));
      await authModel.purgeTokens();
      showSuccessSnackbar(context, "Successfully logged out");
      context.go("/login");
    } catch (e) {
      showErrorSnackbar(context, e as dynamic);
    }
  }

  Widget? getIconButton() {
    if (widget.leadingArrowRedirect != null) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go(widget.leadingArrowRedirect ?? "/",
              extra: widget.leadingArrowExtra);
        },
      );
    } else {
      return null;
    }
  }

  Widget getUserAvatar() {
    if (widget.hideAvatar == true) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton(
        child: const UserAvatar(),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () => _logout(),
                child: const Text('Logout'),
              ),
            ),
          ];
        });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: getIconButton(),
      title: Text(widget.titleText),
      surfaceTintColor: widget.surfaceTintColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: getUserAvatar(),
        ),
        ...widget.actions ?? [],
      ],
      centerTitle: false,
    );
  }
}
