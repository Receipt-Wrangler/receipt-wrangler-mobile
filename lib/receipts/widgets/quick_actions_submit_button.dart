import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';

import '../../models/receipt_model.dart';

class ReceiptQuickActionsSubmitButton extends StatefulWidget {
  const ReceiptQuickActionsSubmitButton({super.key});

  @override
  State<ReceiptQuickActionsSubmitButton> createState() =>
      _ReceiptQuickActionsSubmitButton();
}

class _ReceiptQuickActionsSubmitButton
    extends State<ReceiptQuickActionsSubmitButton> {
  late final formKey =
      Provider.of<ReceiptModel>(context, listen: false).quickActionsFormKey;

  void onSubmitPressed() {
    if (formKey.currentState!.saveAndValidate()) {}
    print(formKey.currentState!.value);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSubmitButton(onPressed: onSubmitPressed, buttonText: "Split");
  }
}
