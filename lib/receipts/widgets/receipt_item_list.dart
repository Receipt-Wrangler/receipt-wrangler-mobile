import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_items.dart';

class ReceiptItemField extends FormBuilderField<List<api.Item>> {
  ReceiptItemField({
    required String name,
    required String label,
    required List<api.Item>? initialValue,
  }) : super(
          key: Key(name),
          name: name,
          initialValue: initialValue ?? [],
          builder: (FormFieldState<List<api.Item>?> field) {
            return InputDecorator(
              decoration: InputDecoration(labelText: label),
              child: ReceiptItemItems(
                items: initialValue ?? [],
              ),
            );
          },
        );
}
