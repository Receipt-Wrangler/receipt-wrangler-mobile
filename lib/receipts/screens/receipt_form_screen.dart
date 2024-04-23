import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';

class ReceiptFormScreen extends StatefulWidget {
  const ReceiptFormScreen({super.key});

  @override
  State<ReceiptFormScreen> createState() => _ReceiptFormScreen();
}

class _ReceiptFormScreen extends State<ReceiptFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: const ReceiptForm());
  }
}
