import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchModel extends ChangeNotifier {
  BehaviorSubject<String> _searchTermBehaviorSubject =
      BehaviorSubject<String>();

  BehaviorSubject<String> get searchTermBehaviorSubject =>
      _searchTermBehaviorSubject;
}
