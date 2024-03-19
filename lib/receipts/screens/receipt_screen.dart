import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreen();
}

class _ReceiptScreen extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    var uri = GoRouterState.of(context).uri;
    var formState = getFormState(uri.toString());
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);

    return ReceiptForm();
  }
}
