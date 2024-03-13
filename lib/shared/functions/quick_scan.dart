import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';

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

Widget _getSubmitButton(GlobalKey<FormBuilderState> formKey,
    StreamController<MultipartFile?> streamController) {
  return BottomSubmitButton(
    onPressed: () async {
      await _submitQuickScan(formKey, streamController);
    },
  );
}

Future<void> _submitQuickScan(GlobalKey<FormBuilderState> formKey,
    StreamController<MultipartFile?> streamController) async {
  if (await streamController.stream.first != null &&
      formKey.currentState!.saveAndValidate()) {
    print(formKey.currentState?.value);
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
      bottomSheetWidget: _getSubmitButton(formKey, streamController));
}
