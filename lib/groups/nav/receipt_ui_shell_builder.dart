import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/classes/base_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/shared/classes/receipt_navigation_extras.dart';
import 'package:receipt_wrangler_mobile/utils/bottom_sheet.dart';

class ReceiptUIShellBuilder implements BaseUIShellBuilder {
  static void setupBottomNav(BuildContext context, GoRouter router) {
    var provider = Provider.of<BottomNavModel>(context, listen: false);
    provider.setIndexSelected(0);

    var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;

    onDestinationSelected(int indexSelected) {
      switch (indexSelected) {
        case 0:
          context.go("/receipts/${receipt.id}/view",
              extra: ReceiptNavigationExtras(
                  name: receipt.name, groupId: receipt.groupId.toString()));
          break;
        case 1:
          var receipt =
              Provider.of<ReceiptModel>(context, listen: false).receipt;
          showFullscreenBottomSheet(
              context, const ReceiptImages(), "${receipt.name} Images");
          break;
        case 2:
          context.go("/search");
          break;
        default:
          context.go("/groups");
      }
    }

    setIndexSelected() {
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
    ];

    provider.setBottomNavData(
        destinations, onDestinationSelected, setIndexSelected);
  }
}
