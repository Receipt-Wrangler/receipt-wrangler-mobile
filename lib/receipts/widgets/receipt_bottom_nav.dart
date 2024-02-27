import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptBottomNav extends StatefulWidget {
  ReceiptBottomNav({super.key});

  late api.Receipt receipt = getDefaultReceipt();

  @override
  State<ReceiptBottomNav> createState() => _ReceiptBottomNav();
}

class _ReceiptBottomNav extends State<ReceiptBottomNav> {
  var indexSelected = 0;

  void _onDestinationSelected(int indexSelected) {
    switch (indexSelected) {
      case 0:
        context.go("/receipts/${widget.receipt.id}/view");
        break;
      case 1:
        context.go(
          "/receipts/${widget.receipt.id}/view/images",
        );
        break;
      case 2:
        context.go("/search");
        break;
      default:
        context.go("/groups");
    }
  }

  int _setIndexSelected() {
    var uri =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    var index = 0;

    if (uri.contains("/receipts/${widget.receipt.id}/view")) {
      index = 0;
    } else if (uri.contains("images")) {
      index = 1;
    } else if (uri.contains("/search")) {
      index = 2;
    }

    return index;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    widget.receipt = receiptModel.receipt;

    return BottomNav(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.receipt),
          label: "Receipt",
        ),
        NavigationDestination(
          icon: Icon(Icons.image),
          label: "Images",
        ),
      ],
      onDestinationSelected: _onDestinationSelected,
      getInitialSelectedIndex: _setIndexSelected,
    );
  }
}
