import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(
    context, StreamController<MultipartFile?> streamController) {
  return IconButton(
    icon: const Icon(Icons.add_a_photo),
    onPressed: () async {
      var uploadedImages = await scanImagesMultiPart(1);
      if (uploadedImages.isNotEmpty) {
        streamController.add(uploadedImages.first);
      }
    },
  );
}

Widget _getSubmitButton(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
    StreamController<MultipartFile?> streamController) {
  MultipartFile? image;
  streamController.stream.listen((event) {
    image = event;
  });
  return BottomSubmitButton(
    onPressed: () async {
      await _submitQuickScan(context, formKey, image);
    },
  );
}

Future<void> _submitQuickScan(BuildContext context,
    GlobalKey<FormBuilderState> formKey, MultipartFile? image) async {
  if (image != null && formKey.currentState!.saveAndValidate()) {
    var form = formKey.currentState!.value;
    try {
      await api.ReceiptApi().quickScanReceipt(
          image, form["groupId"], form["paidByUserId"], form["status"]);
      showSuccessSnackbar(context, "Quick scan successfully uploaded");
    } catch (e) {
      print(e);
      showApiErrorSnackbar(context, e as dynamic);
      return;
    }
  }

  return;
}

showQuickScanBottomSheet(context) {
  MultipartFile? image;
  StreamController<MultipartFile?> streamController =
      StreamController.broadcast();

  List<Widget> actions = [_getUploadIcon(context, streamController)];
  var formKey = GlobalKey<FormBuilderState>();

  showFullscreenBottomSheet(
      context,
      QuickScan(
        formKey: formKey,
        imageStream: streamController.stream,
      ),
      "Quick Scan",
      actions: actions,
      bottomSheetWidget: _getSubmitButton(context, formKey, streamController));
}
