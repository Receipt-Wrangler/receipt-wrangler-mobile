import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/persistence/global_shared_preferences.dart';

class ServerModel extends ChangeNotifier {
  final _basePathKey = "basePath";

  String get basePath =>
      GlobalSharedPreferences.instance.getString(_basePathKey) ?? "";

  FeatureConfig _featureConfig =
      FeatureConfig(aiPoweredReceipts: false, enableLocalSignUp: false);

  FeatureConfig get featureConfig => _featureConfig;

  void setBasePath(String basePath) {
    GlobalSharedPreferences.instance.setString(_basePathKey, basePath);

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
}
