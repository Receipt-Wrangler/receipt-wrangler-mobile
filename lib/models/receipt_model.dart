import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptModel extends ChangeNotifier {
  Receipt _receipt = getDefaultReceipt();

  Receipt get receipt => _receipt;

  final StreamController<FileDataView> _streamController =
      StreamController<FileDataView>.broadcast();

  Stream<FileDataView> get imagesStream => _streamController.stream;

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    if (notify) {
      notifyListeners();
    }
  }

  void pushImage(FileDataView file) {
    _streamController.add(file);
  }
}
