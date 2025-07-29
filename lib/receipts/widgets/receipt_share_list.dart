import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_shares.dart';

import '../../models/receipt_model.dart';

class ReceiptShareField extends StatefulWidget {
  const ReceiptShareField({super.key, required this.groupId});

  final int groupId;

  @override
  _ReceiptShareFieldState createState() {
    return _ReceiptShareFieldState();
  }
}

class _ReceiptShareFieldState extends State<ReceiptShareField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptModel>(
      builder: (context, consumerModel, child) {
        return InputDecorator(
          decoration: const InputDecoration(labelText: "Shared With"),
          child: ReceiptItemShares(
            items: consumerModel.items ?? [],
            groupId: widget.groupId,
          ),
        );
      },
    );
  }
}
