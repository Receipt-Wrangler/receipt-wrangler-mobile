import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api.dart';

class GroupModel extends ChangeNotifier {
  List<Group> _groups = [];

  List<Group> get groups => _groups;

  void setGroups(List<Group> groups) {
    _groups = groups;

    notifyListeners();
  }

  Group? getGroupById(String id) {
    try {
      return _groups.firstWhere((group) => group.id == int.tryParse(id));
    } catch (e) {
      return null;
    }
  }
}
