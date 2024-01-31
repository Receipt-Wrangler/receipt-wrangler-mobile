import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

Future<String?> protectedRouteRedirect(
    BuildContext context, String? redirect) async {
  // TODO: check server connection
  var authModelProvider = Provider.of<AuthModel>(context, listen: false);
  var groupModel = Provider.of<GroupModel>(context, listen: false);
  var tokensValid = await refreshTokens(authModelProvider, groupModel);
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

  var tokensValid = await refreshTokens(authModelProvider, groupModel);
  var redirectRoute = redirect ?? "/";

  if (tokensValid) {
    return redirectRoute;
  } else {
    return null;
  }
}
