import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';

Future<bool> refreshTokens(AuthModel authModelProvider) async {
  var jwt = await authModelProvider.getJwt();
  var refreshToken = await authModelProvider.getRefreshToken();

  // If token is valid, then continue on
  if (isTokenValid(jwt)) {
    return true;
  } else {
    // If token is invalid, but refresh token is valid, then get a new token pair
    if (isTokenValid(refreshToken)) {
      try {
        var tokenPair = await AuthApi().getNewRefreshToken();
        authModelProvider.setJwt(tokenPair!.jwt);
        authModelProvider.setRefreshToken(tokenPair!.refreshToken);
        return true;
      } catch (e) {
        // If the refresh fails, redirect to redirect path and consider it a failure
        authModelProvider.purgeTokens();
        return false;
      }
    } else {
      // purge old tokens
      authModelProvider.purgeTokens();
      return false;
    }
  }
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
