import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../../receipts/widgets/quick_scan.dart';
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
  return BottomSubmitButton(
    onPressed: () async {
      await _submitQuickScan(context, formKey, streamController);
    },
  );
}

Future<void> _submitQuickScan(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
    StreamController<MultipartFile?> streamController) async {
  var file = await streamController.stream.first;
  if (file != null && formKey.currentState!.saveAndValidate()) {
    var form = formKey.currentState!.value;
    try {
      await api.ReceiptApi().quickScanReceipt(
          file, form["groupId"], form["paidByUserId"], form["status"]);
      showSuccessSnackbar(context, "Quick scan successfully uploaded");
    } catch (e) {
      showApiErrorSnackbar(context, e as dynamic);
      return;
    }
  }

  return;
}

showQuickScanBottomSheet(context) {
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
