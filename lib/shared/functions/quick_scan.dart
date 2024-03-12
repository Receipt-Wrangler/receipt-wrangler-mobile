import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';

import '../../receipts/widgets/quick_scan.dart';
import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(
    context, StreamController<MultipartFile?> streamController) {
  return IconButton(
    icon: const Icon(Icons.add_a_photo),
    onPressed: () async {
      // TODO: finish implementing this
      var uploadedImages = await scanImagesMultiPart(1);
      if (uploadedImages.isNotEmpty) {
        streamController.add(uploadedImages.first);
      }
    },
  );
}

showQuickScanBottomSheet(context) {
  StreamController<MultipartFile?> streamController =
      StreamController.broadcast();
  List<Widget> actions = [_getUploadIcon(context, streamController)];

  showFullscreenBottomSheet(
      context,
      QuickScan(
        imageStream: streamController.stream,
      ),
      "Quick Scan",
      actions: actions);
}
