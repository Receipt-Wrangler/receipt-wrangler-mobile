import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

Future<String?> protectedRouteRedirect(
    BuildContext context, String? redirect) async {
  var authModelProvider = Provider.of<AuthModel>(context, listen: false);
  var tokensValid = await refreshTokens(authModelProvider);
  var redirectRoute = redirect ?? "/";

  if (tokensValid) {
    return null;
  } else {
    return redirectRoute;
  }
}
