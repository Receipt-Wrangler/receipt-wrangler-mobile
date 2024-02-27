import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptImagesScreen extends StatefulWidget {
  const ReceiptImagesScreen({
    super.key,
  });

  @override
  State<ReceiptImagesScreen> createState() => _ReceiptImagesScreen();
}

class _ReceiptImagesScreen extends State<ReceiptImagesScreen> {
  @override
  Widget build(BuildContext context) {
    var uri = GoRouterState.of(context).uri;
    var formState = getFormState(uri.toString());
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    var receipt = receiptModel.receipt;

    return Scaffold(
      appBar: TopAppBar(
        titleText: getTitleText(formState, receipt.name),
      ),
      body: const ReceiptImages(),
    );
  }
}
