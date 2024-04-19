import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';

import '../nav/receipt_bottom_nav.dart';

class ReceiptImageScreen extends StatefulWidget {
  const ReceiptImageScreen({super.key});

  @override
  State<ReceiptImageScreen> createState() => _ReceiptImageScreen();
}

class _ReceiptImageScreen extends State<ReceiptImageScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        appBarWidget: ReceiptAppBar(),
        bodyPadding: const EdgeInsets.all(0),
        bottomNavigationBarWidget: const ReceiptBottomNav(),
        child: ReceiptImages());
  }
}
