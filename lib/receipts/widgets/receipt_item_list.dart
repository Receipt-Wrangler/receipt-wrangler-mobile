import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_item_items.dart';

import '../../models/receipt_model.dart';

class ReceiptItemField extends StatefulWidget {
  const ReceiptItemField({
    super.key, 
    required this.groupId, 
    required this.formKey,
    this.forceExpanded = false,
  });

  final int groupId;
  final GlobalKey<FormBuilderState> formKey;
  final bool forceExpanded;

  @override
  _ReceiptItemFieldState createState() {
    return _ReceiptItemFieldState();
  }
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
          decoration: const InputDecoration(labelText: "Items"),
          child: ReceiptItemItems(
            groupId: widget.groupId,
            formKey: widget.formKey,
            forceExpanded: widget.forceExpanded,
          ),
        );
      },
    );
  }
}
