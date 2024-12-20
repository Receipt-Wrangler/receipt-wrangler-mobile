import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/currency.dart';
import 'package:receipt_wrangler_mobile/models/context_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';

import '../../interfaces/form_item.dart';
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
  late final userModel = Provider.of<UserModel>(context, listen: false);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final shellContext =
      Provider.of<ContextModel>(context, listen: false).shellContext;

  List<api.UserView> getSelectedUsers() {
    return formKey.currentState!.value["users"] as List<api.UserView>;
  }

  List<FormItem> buildEvenSplitFormItems(String amount) {
    var selectedUsers = getSelectedUsers();

    var receiptAmount = Money.parse(amount.length == 0 ? "0" : amount,
        isoCode: customCurrencyISOCode);
    var divisor = Money.parse(selectedUsers.length.toString(),
        isoCode: customCurrencyISOCode);

    double equalSplit = receiptAmount.dividedBy(divisor);
    var items = [...receiptModel.items];

    selectedUsers.forEach((user) {
      var newItem = (api.ItemBuilder()
            ..name = "${user.displayName}'s Even Portion"
            ..amount = equalSplit.toString()
            ..chargedToUserId = user.id
            ..receiptId = receiptModel.receipt.id
            ..status = api.ItemStatus.OPEN)
          .build();

      items.add(FormItem.fromItem(newItem));
    });

    return items;
  }

  // TODO: don't forget about validation
  void splitEvenly() {
    if (formKey.currentState!.saveAndValidate()) {
      var formAmount =
          receiptModel.receiptFormKey.currentState!.fields["amount"]!.value;
      List<FormItem> items = buildEvenSplitFormItems(formAmount);
      receiptModel.setItems(items);
      Navigator.pop(shellContext as BuildContext);
    }
  }

  void splitEvenlyWithPortions() {
    if (formKey.currentState!.saveAndValidate()) {
      List<FormItem> userPortionsItems = [];
      var selectedUsers = getSelectedUsers();
      var remainingAmount = Money.parse(
          receiptModel.receiptFormKey.currentState!.fields["amount"]!.value,
          isoCode: customCurrencyISOCode);

      selectedUsers.forEach((user) {
        var splitAmount =
            formKey.currentState!.fields["${user.id}"]!.value.toString();

        if (splitAmount.length > 0) {
          var splitCurrency =
              Money.parse(splitAmount, isoCode: customCurrencyISOCode);
          remainingAmount = remainingAmount - splitCurrency;

          var newItem = (api.ItemBuilder()
                ..name = "${user.displayName}'s Portion"
                ..amount = splitCurrency.toDouble().toString()
                ..chargedToUserId = user.id
                ..receiptId = receiptModel.receipt.id
                ..status = api.ItemStatus.OPEN)
              .build();

          userPortionsItems.add(FormItem.fromItem(newItem));
        }
      });

      receiptModel.setItems([
        ...buildEvenSplitFormItems(remainingAmount.toDouble().toString()),
        ...userPortionsItems
      ]);
      Navigator.pop(shellContext as BuildContext);
    }
  }

  void onSubmitPressed() {
    if (formKey.currentState!.saveAndValidate()) {
      var quickActionSelection =
          formKey.currentState!.value["quickActionsSelection"] as List<bool>;
      var selected = quickActionSelection.indexOf(true);
      switch (selected) {
        case 0:
          splitEvenly();
        case 1:
          splitEvenlyWithPortions();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSubmitButton(onPressed: onSubmitPressed, buttonText: "Split");
  }
}
