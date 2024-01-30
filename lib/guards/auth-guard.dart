import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Future<String?> canNavigateTo(BuildContext context, String? redirect) async {
  return Provider.of<AuthModel>(context, listen: false)
      .getJwt()
      .then((jwt) async {
    var defaultRoute = "/";
    var refreshToken =
        await Provider.of<AuthModel>(context, listen: false).getRefreshToken();

    if (isTokenValid(jwt)) {
      return redirect ?? defaultRoute;
    } else {
      if (isTokenValid(refreshToken)) {
        var tokenPair = await AuthApi().getNewRefreshToken();
      } else {
        // purge old tokens
        return defaultRoute;
      }
    }
  });
}

bool isTokenValid(String? token) {
  if (token == null || token.isEmpty) {
    return false;
  } else {
    var claims = JWT.decode(token);
    DateTime expiration = DateTime.fromMillisecondsSinceEpoch(
        claims.payload["exp"] * 1000,
        isUtc: false);

    return expiration.isAfter(DateTime.now());
  }
}
