import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';

import '../../api.dart' as api;
import '../../models/receipt_model.dart';
import '../../shared/widgets/circular_loading_progress.dart';

Widget buildReceiptFormRoute(BuildContext context, GoRouterState state) {
  var future = api.ReceiptApi()
      .getReceiptById(int.parse(state.pathParameters['receiptId'] as String));

  return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        var isReady = snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData;

        if (isReady) {
          var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
          receiptModel.setReceipt(snapshot.data as api.Receipt, false);
        }

        return isReady
            ? SingleChildScrollView(
                child: const ReceiptForm(),
              )
            : const CircularLoadingProgress();
      });
}
