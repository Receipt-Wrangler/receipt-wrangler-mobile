import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api.dart';

class UserPreferencesModel extends ChangeNotifier {
  UserPreferences _userPreferences = UserPreferences(
    id: 0,
    userId: 0,
    createdAt: "",
  );

  UserPreferences get userPreferences => _userPreferences;

  void setUserPreferences(UserPreferences userPreferences) {
    _userPreferences = userPreferences;

    notifyListeners();
  }
}
