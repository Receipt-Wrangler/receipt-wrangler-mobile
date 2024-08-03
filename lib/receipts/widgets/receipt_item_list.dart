import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_items.dart';

import '../../models/receipt_model.dart';

class ReceiptItemField extends StatefulWidget {
  const ReceiptItemField();

  @override
  _ReceiptItemFieldState createState() {
    return _ReceiptItemFieldState();
  }

/*  ReceiptItemField({
    required String name,
    required String label,
    required List<api.Item>? initialValue,
  }) : super(
          key: Key(name),
          name: name,
          builder: (FormFieldState<List<api.Item>?> field) {
            return InputDecorator(
              decoration: InputDecoration(labelText: label),
              child: ReceiptItemItems(
                items: initialValue ?? [],
              ),
            );
          },
        );*/
}

class _ReceiptItemFieldState extends State<ReceiptItemField> {
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
          child: ReceiptItemItems(
            items: consumerModel.items ?? [],
          ),
        );
      },
    );
  }
}
