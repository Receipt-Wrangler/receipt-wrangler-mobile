import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

class TagModel extends ChangeNotifier {
  List<Tag> _tags = [];
  List<Tag> get tags => _tags;

  void setTags(List<Tag> tags) {
    _tags = tags;

    notifyListeners();
  }
}
