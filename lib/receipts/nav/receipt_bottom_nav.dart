import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';

import '../../api/api.dart' as api;
import '../../service/file_upload.dart';
import '../../utils/snackbar.dart';

class ReceiptBottomNav extends StatefulWidget {
  const ReceiptBottomNav({super.key});

  @override
  State<ReceiptBottomNav> createState() => _ReceiptBottomNav();
}

class _ReceiptBottomNav extends State<ReceiptBottomNav> {
  var indexSelectedController = StreamController<int>();
  var imagesAddedController = StreamController<api.FileDataView>.broadcast();

  @override
  Widget build(BuildContext context) {
    Widget getImageUploadIcon(context, api.Receipt receipt) {
      return IconButton(
        icon: const Icon(Icons.add_a_photo),
        onPressed: () async {
          try {
            var filesUploaded =
                await uploadImagesToReceipt(receipt.id.toString());
            if (filesUploaded.isNotEmpty) {
              showSuccessSnackbar(context,
                  "Successfully uploaded ${filesUploaded.length} images");
              for (var file in filesUploaded) {
                imagesAddedController.add(file);
              }
            }
          } catch (e) {
            print(e);
            return;
          }
        },
      );
    }

    onDestinationSelected(int indexSelected) {
      var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
      switch (indexSelected) {
        case 0:
          context.go("/receipts/${receipt.id}/view");
          break;
        case 1:
          context.go("/receipts/${receipt.id}/images/view");
          break;
        case 2:
          context.go("/search");
          break;
        default:
          context.go("/groups");
      }
    }

    setIndexSelected() {
      var fullPath = GoRouterState.of(context).fullPath ?? "";
      if (fullPath == "/receipts/:receiptId/view") {
        return 0;
      }

      if (fullPath == "/receipts/:receiptId/images/view") {
        return 1;
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
    ];

    return BottomNav(
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
