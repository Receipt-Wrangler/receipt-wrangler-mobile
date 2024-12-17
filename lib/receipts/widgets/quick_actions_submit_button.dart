import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';

class ReceiptQuickActionsSubmitButton extends StatefulWidget {
  const ReceiptQuickActionsSubmitButton({super.key});

  @override
  State<ReceiptQuickActionsSubmitButton> createState() =>
      _ReceiptQuickActionsSubmitButton();
}

class _ReceiptQuickActionsSubmitButton
    extends State<ReceiptQuickActionsSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return BottomSubmitButton(onPressed: () {}, buttonText: "Split");
  }
}
