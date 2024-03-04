import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/app_bar_model.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
  });

  @override
  State<TopAppBar> createState() => _TopAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _TopAppBar extends State<TopAppBar> {
  void _logout() {
    AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    authModel
        .getRefreshToken()
        .then((refreshToken) {
          return refreshToken;
        })
        .then((refreshToken) => api.AuthApi().logout(
            logoutCommand: api.LogoutCommand(refreshToken: refreshToken ?? "")))
        .then((value) {
          authModel.purgeTokens();
          showSuccessSnackbar(context, "Successfully logged out!");
          context.go('/login');
        });
  }

  Widget? getIconButton(AppBarModel appBarModel) {
    if (appBarModel.leadingArrowRedirect != null) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go(appBarModel.leadingArrowRedirect ?? "/",
              extra: appBarModel.leadingArrowExtra);
        },
      );
    } else {
      return null;
    }
  }

  Widget getUserAvatar() {
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
    return Consumer<AppBarModel>(
      builder: (context, appBarModel, child) {
        return AppBar(
          leading: getIconButton(appBarModel),
          title: Text(
            appBarModel.titleText,
          ),
          actions: [getUserAvatar()],
          centerTitle: false,
        );
      },
    );
  }
}
