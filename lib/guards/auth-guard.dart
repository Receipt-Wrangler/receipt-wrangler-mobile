import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/category_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/tag_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

import '../models/auth_model.dart';

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
  print("running route redirect");
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
    return redirectRoute;
  } else {
    await authModelProvider.purgeTokens();
    return null;
  }
}
