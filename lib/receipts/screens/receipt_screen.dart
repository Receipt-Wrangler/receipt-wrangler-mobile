import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/shared/classes/receipt_navigation_extras.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

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

    return ScreenWrapper(
        appBarWidget: TopAppBar(
          titleText: "${getFormStateHeader(formState)} ${extra.name} Receipt",
          leadingArrowRedirect: "/groups/${extra.groupId}/receipts",
        ),
        //bottomNavigationBarWidget: const GroupDashboardBottomNav(),
        children: [
          FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ReceiptForm(
                      receipt: snapshot.data as api.Receipt,
                      formState: formState);
                }

                return const CircularProgressIndicator();
              }),
        ]);
  }
}