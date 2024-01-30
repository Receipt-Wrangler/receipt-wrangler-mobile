import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthModel extends ChangeNotifier {
  dynamic _claims = {};
  dynamic get claims => _claims;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final String _refreshTokenKey = "refreshToken";
  final String _jwtKey = "jwt";

  void setClaims(dynamic claims) {
    _claims = claims;

    notifyListeners();
  }

  void setJwt(String? jwt) {
    _storage.write(key: _jwtKey, value: jwt ?? null);

    notifyListeners();
  }

  void setRefreshToken(String? refreshToken) {
    _storage.write(key: _refreshTokenKey, value: refreshToken ?? null);

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
}
