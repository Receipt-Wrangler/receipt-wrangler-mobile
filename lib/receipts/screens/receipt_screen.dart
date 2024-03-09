import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';
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
    var receiptId = int.parse(
        GoRouterState.of(context).pathParameters['receiptId'] as String);
    var future = api.ReceiptApi().getReceiptById(receiptId);
    var formState = getFormState(uri.toString());
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            receiptModel.setReceipt(snapshot.data as api.Receipt, true);
            return SingleChildScrollView(
              child: ReceiptForm(
                  receipt: snapshot.data as api.Receipt, formState: formState),
            );
          }

          return const CircularLoadingProgress();
        });
  }
}
