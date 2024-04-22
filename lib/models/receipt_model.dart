import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/api.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptModel extends ChangeNotifier {
  Receipt _receipt = getDefaultReceipt();

  Receipt get receipt => _receipt;

  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  BehaviorSubject<List<FileDataView?>> _imageBehaviorSubject =
      BehaviorSubject<List<FileDataView?>>.seeded([]);

  BehaviorSubject<List<FileDataView?>> get imageBehaviorSubject =>
      _imageBehaviorSubject;

  InfiniteScrollController _infiniteScrollController =
      InfiniteScrollController();

  InfiniteScrollController get infiniteScrollController =>
      _infiniteScrollController;

  var _receiptFormKey = GlobalKey<FormBuilderState>();

  GlobalKey<FormBuilderState> get receiptFormKey => _receiptFormKey;

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    _comments = receipt.comments;

    _receiptFormKey = GlobalKey<FormBuilderState>();

    if (notify) {
      notifyListeners();
    }
  }

  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }
}
