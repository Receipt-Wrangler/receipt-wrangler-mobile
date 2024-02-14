import 'package:flutter/material.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;

class ReceiptListItem extends StatefulWidget {
  const ReceiptListItem({super.key, required this.data});

  final api.PagedDataDataInner data;

  @override
  State<ReceiptListItem> createState() => _ReceiptListItem();
}

class _ReceiptListItem extends State<ReceiptListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data.name),
    );
  }
}
