import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';

Future<String?> canNavigateTo(BuildContext context, String? redirect) async {
  return Provider.of<AuthModel>(context, listen: false).getJwt().then((jwt) {
    var defaultRoute = "/";

    if (isTokenValid(jwt)) {
      return redirect ?? defaultRoute;
    } else {
      return defaultRoute;
    }
  });
}

bool isTokenValid(String? token) {
  return token!.isNotEmpty;
}
