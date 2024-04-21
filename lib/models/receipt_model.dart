import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptModel extends ChangeNotifier {
  Receipt _receipt = getDefaultReceipt();

  Receipt get receipt => _receipt;

  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    _comments = receipt.comments;

    if (notify) {
      notifyListeners();
    }
  }

  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }
}
