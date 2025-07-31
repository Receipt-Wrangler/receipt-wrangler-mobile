import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';

class SyncWithItemsCheckbox extends StatelessWidget {
  const SyncWithItemsCheckbox({
    super.key,
    required this.formState,
  });

  final WranglerFormState formState;

  @override
  Widget build(BuildContext context) {
    // Only show in edit mode
    if (formState != WranglerFormState.edit) {
      return const SizedBox.shrink();
    }

    return Consumer<ReceiptModel>(
      builder: (context, receiptModel, child) {
        return CheckboxListTile(
          title: const Text('Sync with items'),
          subtitle: const Text('Automatically calculate receipt amount from item totals'),
          value: receiptModel.syncWithItems,
          onChanged: (bool? value) {
            receiptModel.setSyncWithItems(value ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}