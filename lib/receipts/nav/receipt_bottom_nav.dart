import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/routes.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../../utils/forms.dart';

class ReceiptBottomNav extends StatefulWidget {
  const ReceiptBottomNav({super.key});

  @override
  State<ReceiptBottomNav> createState() => _ReceiptBottomNav();
}

class _ReceiptBottomNav extends State<ReceiptBottomNav> {
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  var indexSelectedController = StreamController<int>();
  var imagesAddedController = StreamController<api.FileDataView>.broadcast();

  void updateModifiedReceipt() {
    var formState = getFormStateFromContext(context);
    receiptModel.receiptFormKey.currentState!.save();
    var form = {...receiptModel.receiptFormKey.currentState!.value};
    var date = "";

    if (formState == WranglerFormState.view) {
      date = convertDateFormatForForm(form["date"]);
    } else {
      try {
        date = formatDate(zuluDateFormat, form["date"] as DateTime);
      } catch (e) {
        var zuluDate = convertDateFormatForForm(form["date"]);
        date = formatDate(zuluDateFormat, DateTime.parse(zuluDate));
      }
    }
    var modifiedReceipt = (api.ReceiptBuilder()
          ..id = receiptModel.receipt.id
          ..name = form["name"] ?? ""
          ..amount = form["amount"] ?? "0"
          ..date = date
          ..groupId = int.parse((form["groupId"] ?? "0").toString())
          ..paidByUserId = int.parse((form["paidByUserId"] ?? "0").toString())
          ..status = form["status"] as api.ReceiptStatus
          ..comments = ListBuilder(receiptModel.comments ?? [])
          ..categories = ListBuilder(List<api.Category>.from(
              (form["categories"] ?? []).map((item) => item as api.Category)))
          ..tags = ListBuilder(List<api.Tag>.from(
              (form["tags"] ?? []).map((item) => item as api.Tag))))
        .build();

    receiptModel.setModifiedReceipt(modifiedReceipt!);
  }

  @override
  Widget build(BuildContext context) {
    var formState = getFormStateFromContext(context);
    var formStateName = formState.name;

    onDestinationSelected(int indexSelected) {
      var receipt = receiptModel.receipt;

      if (receiptModel.receiptFormKey.currentState != null) {
        updateModifiedReceipt();
      }

      if (formState != WranglerFormState.add) {
        switch (indexSelected) {
          case 0:
            context.go("/receipts/${receipt.id}/${formStateName}");
            break;
          case 1:
            context.go("/receipts/${receipt.id}/images/${formStateName}");
            break;
          case 2:
            context.go("/receipts/${receipt.id}/comments/${formStateName}");
            break;
          default:
            context.go("/groups");
        }
      } else {
        switch (indexSelected) {
          case 0:
            context.go("/receipts/${formStateName}");
            break;
          case 1:
            context.go("/receipts/images/${formStateName}");
            break;
          case 2:
            context.go("/receipts/comments/${formStateName}");
            break;
          default:
            context.go("/groups");
        }
      }
    }

    setIndexSelected() {
      var fullPath = GoRouterState.of(context).fullPath ?? "";
      if (fullPath == fullReceiptViewPath) {
        return 0;
      }

      if (fullPath.contains("images")) {
        return 1;
      }

      if (fullPath.contains("comments")) {
        return 2;
      }

      return 0;
    }

    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.receipt),
        label: "Receipt",
      ),
      NavigationDestination(
        icon: Icon(Icons.image),
        label: "Images",
      ),
      NavigationDestination(
        icon: Icon(Icons.chat_bubble),
        label: "Comments",
      ),
    ];

    return BottomNav(
      key: const Key("receipt_bottom_nav"),
      destinations: destinations,
      onDestinationSelected: onDestinationSelected,
      getInitialSelectedIndex: setIndexSelected,
      indexSelectedController: indexSelectedController,
    );
  }

  @override
  void dispose() {
    indexSelectedController.close();
    imagesAddedController.close();
    super.dispose();
  }
}
