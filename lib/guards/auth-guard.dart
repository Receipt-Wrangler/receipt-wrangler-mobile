import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_select_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/models/app_bar_model.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';
import 'package:receipt_wrangler_mobile/models/category_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/tag_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

Future<String?> protectedRouteRedirect(
    BuildContext context, String? redirect) async {
  // TODO: check server connection
  var authModelProvider = Provider.of<AuthModel>(context, listen: false);
  var groupModel = Provider.of<GroupModel>(context, listen: false);
  var userModel = Provider.of<UserModel>(context, listen: false);
  var userPreferencesModel =
      Provider.of<UserPreferencesModel>(context, listen: false);
  var categoryModel = Provider.of<CategoryModel>(context, listen: false);
  var tagModel = Provider.of<TagModel>(context, listen: false);

  var tokensValid = await refreshTokens(authModelProvider, groupModel,
      userModel, userPreferencesModel, categoryModel, tagModel);
  var redirectRoute = redirect ?? "/";

  if (tokensValid) {
    return null;
  } else {
    return redirectRoute;
  }
}

Future<String?> unprotectedRouteRedirect(
    BuildContext context, String? redirect) async {
  // TODO: check server connection
  var authModelProvider = Provider.of<AuthModel>(context, listen: false);
  var groupModel = Provider.of<GroupModel>(context, listen: false);
  var userModel = Provider.of<UserModel>(context, listen: false);
  var userPreferencesModel =
      Provider.of<UserPreferencesModel>(context, listen: false);
  var categoryModel = Provider.of<CategoryModel>(context, listen: false);
  var tagModel = Provider.of<TagModel>(context, listen: false);
  var bottomNavModel = Provider.of<BottomNavModel>(context, listen: false);
  var appBarModel = Provider.of<AppBarModel>(context, listen: false);

  var tokensValid = await refreshTokens(authModelProvider, groupModel,
      userModel, userPreferencesModel, categoryModel, tagModel);
  var redirectRoute = redirect ?? "/";

  if (tokensValid) {
    GroupSelectUIShellBuilder.setupBottomNav(context);
    appBarModel.setAppBarData(titleText: "Groups");

    return redirectRoute;
  } else {
    bottomNavModel.setBottomNavData([], (int index) {}, () => 0);
    appBarModel.setAppBarData(titleText: "");
    return null;
  }
}
