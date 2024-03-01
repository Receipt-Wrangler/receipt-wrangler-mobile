import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptModel extends ChangeNotifier {
  Receipt _receipt = getDefaultReceipt();
  Receipt get receipt => _receipt;

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    if (notify) {
      notifyListeners();
    }
  }
}
