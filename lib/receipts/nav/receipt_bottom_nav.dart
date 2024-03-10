import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';

import '../../api/api.dart' as api;
import '../../service/file_upload.dart';
import '../../utils/bottom_sheet.dart';
import '../../utils/snackbar.dart';
import '../widgets/receipt_images.dart';

class ReceiptBottomNav extends StatefulWidget {
  const ReceiptBottomNav({super.key, required this.receipt});

  final api.Receipt receipt;

  @override
  State<ReceiptBottomNav> createState() => _ReceiptBottomNav();
}

class _ReceiptBottomNav extends State<ReceiptBottomNav> {
  var indexSelectedController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    Widget getImageUploadIcon(context) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () async {
          try {
            var filesUploaded =
                await uploadImagesToReceipt(widget.receipt.id.toString());
            if (filesUploaded > 0) {
              showSuccessSnackbar(
                  context, "Successfully uploaded $filesUploaded images");
            }
            //receiptModel.imagesUploaded();
          } catch (e) {
            print(e);
            return;
          }
        },
      );
    }

    onDestinationSelected(int indexSelected) {
      switch (indexSelected) {
        case 0:
          context.go("/receipts/${widget.receipt.id}/view");
          break;
        case 1:
          showFullscreenBottomSheet(
              context,
              ReceiptImages(receipt: widget.receipt),
              "${widget.receipt.name} Images",
              actions: [getImageUploadIcon(context)]);
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

    return BottomNav(
      destinations: destinations,
      onDestinationSelected: onDestinationSelected,
      getInitialSelectedIndex: setIndexSelected,
      indexSelectedController: indexSelectedController,
    );
  }
}
