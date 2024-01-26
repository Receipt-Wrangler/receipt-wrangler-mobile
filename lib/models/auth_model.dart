import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  dynamic _claims = {};
  dynamic get claims => _claims;

  String _jwt = "";
  String get jwt => _jwt;

  String _refreshToken = "";
  String get refreshToken => _refreshToken;

  void setClaims(dynamic claims) {
    _claims = claims;

    notifyListeners();
  }

  void setJwt(String jwt) {
    _jwt = jwt;

    notifyListeners();
  }

  void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;

    notifyListeners();
  }
}
