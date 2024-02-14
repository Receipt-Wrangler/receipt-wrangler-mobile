import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

class ReceiptListModel extends ChangeNotifier {
  ReceiptPagedRequestCommand _receiptPagedRequestCommand =
      ReceiptPagedRequestCommand(
    page: 1,
    pageSize: 10,
    orderBy: "date",
    sortDirection: SortDirection.desc,
    filter: ReceiptPagedRequestFilter(),
  );
  ReceiptPagedRequestCommand get receiptPagedRequestCommand =>
      _receiptPagedRequestCommand;

  void setReceiptPagedRequestCommand(
      ReceiptPagedRequestCommand command, bool notify) {
    _receiptPagedRequestCommand = command;

    if (notify) {
      notifyListeners();
    }
  }
}
