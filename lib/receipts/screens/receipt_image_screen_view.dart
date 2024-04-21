import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_image_screen_base.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_edit_popup_menu.dart';

class ReceiptImageScreenView extends ReceiptImageScreenBase {
  const ReceiptImageScreenView({super.key});

  @override
  State<ReceiptImageScreenView> createState() => _ReceiptImageScreenView();
}

class _ReceiptImageScreenView
    extends ReceiptImageScreenBaseState<ReceiptImageScreenView> {
  List<PopupMenuEntry> buildViewAppBarMenuOptions() {
    return [
      PopupMenuItem(
          value: "edit",
          child: const Text("Edit"),
          onTap: () => context.go("/receipts/${receipt.id}/images/edit")),
    ];
  }

  Widget buildAppBarMenu() {
    return ReceiptEditPopupMenu(
        groupId: receipt.groupId,
        popupMenuChildren: buildViewAppBarMenuOptions());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isLoadingBehaviorSubject.stream,
        builder: (context, snapshot) {
          Widget widget = ReceiptImages(
            imageStream: receiptModel.imageBehaviorSubject.stream,
            infiniteScrollController: receiptModel.infiniteScrollController,
          );

          if (snapshot.hasData && snapshot.data == true) {
            widget = const Center(child: CircularProgressIndicator());
          }

          return widget;
        });
  }
}
