import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

class ServerModel extends ChangeNotifier {
  String _basePath = "";
  String get basePath => _basePath;

  FeatureConfig _featureConfig =
      FeatureConfig(aiPoweredReceipts: false, enableLocalSignUp: false);
  FeatureConfig get featureConfig => _featureConfig;

  void setBasePath(String basePath) {
    _basePath = basePath;

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
