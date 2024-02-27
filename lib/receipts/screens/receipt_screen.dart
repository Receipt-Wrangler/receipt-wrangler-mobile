import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/shared/classes/receipt_navigation_extras.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreen();
}

class _ReceiptScreen extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    var extra = GoRouterState.of(context).extra as ReceiptNavigationExtras;
    var uri = GoRouterState.of(context).uri;
    var receiptId = int.parse(
        GoRouterState.of(context).pathParameters['receiptId'] as String);
    var future = api.ReceiptApi().getReceiptById(receiptId);
    var formState = getFormState(uri.toString());
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);

    return ScreenWrapper(
        appBarWidget: TopAppBar(
          titleText: getTitleText(formState, extra.name),
          leadingArrowRedirect: "/groups/${extra.groupId}/receipts",
        ),
        bottomNavigationBarWidget: ReceiptBottomNav(),
        children: [
          FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  receiptModel.setReceipt(snapshot.data as api.Receipt, false);
                  return SingleChildScrollView(
                    child: ReceiptForm(
                        receipt: snapshot.data as api.Receipt,
                        formState: formState),
                  );
                }

                return const CircularProgressIndicator();
              }),
        ]);
  }
}
