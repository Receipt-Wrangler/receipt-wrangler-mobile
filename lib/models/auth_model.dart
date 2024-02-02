import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/persistence/global_shared_preferences.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;

class AuthModel extends ChangeNotifier {
  api.Claims? _claims;

  api.Claims? get claims => _claims;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final String _refreshTokenKey = "refreshToken";

  final String _jwtKey = "jwt";

  final _basePathKey = "basePath";

  String get basePath =>
      GlobalSharedPreferences.instance.getString(_basePathKey) ?? "";

  FeatureConfig _featureConfig =
      FeatureConfig(aiPoweredReceipts: false, enableLocalSignUp: false);

  FeatureConfig get featureConfig => _featureConfig;

  void initializeAuth() {
    _updateDefaultApiClient();
  }

  void setClaims(Claims claims) {
    _claims = claims;

    notifyListeners();
  }

  void setJwt(String? jwt) {
    _storage.write(key: _jwtKey, value: jwt ?? null);

    _updateDefaultApiClient();

    notifyListeners();
  }

  void setRefreshToken(String? refreshToken) {
    _storage.write(key: _refreshTokenKey, value: refreshToken ?? null);

    _updateDefaultApiClient();

    notifyListeners();
  }

  void purgeTokens() {
    _storage.delete(key: _jwtKey);
    _storage.delete(key: _refreshTokenKey);

    notifyListeners();
  }

  Future<String?> getJwt() async {
    return await _storage.read(key: _jwtKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  void setBasePath(String basePath) {
    GlobalSharedPreferences.instance.setString(_basePathKey, basePath);

    _updateDefaultApiClient();

    notifyListeners();
  }

  void setFeatureConfig(FeatureConfig? featureConfig) {
    if (featureConfig == null) {
      return;
    } else {
      _featureConfig = featureConfig;
      notifyListeners();
    }
  }

  void _updateDefaultApiClient() {
    getJwt().then((jwt) {
      if (jwt != null) {
        var bearer = api.HttpBearerAuth();
        bearer.accessToken = jwt;

        api.defaultApiClient =
            ApiClient(basePath: basePath, authentication: bearer);
        return;
      }

      api.defaultApiClient = ApiClient(basePath: basePath);
      return;
    });
  }
}
