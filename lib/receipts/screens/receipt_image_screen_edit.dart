import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_image_screen_base.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';

class ReceiptImageScreenEdit extends ReceiptImageScreenBase {
  const ReceiptImageScreenEdit({super.key});

  @override
  State<ReceiptImageScreenEdit> createState() => _ReceiptImageScreenEdit();
}

class _ReceiptImageScreenEdit
    extends ReceiptImageScreenBaseState<ReceiptImageScreenEdit> {
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
