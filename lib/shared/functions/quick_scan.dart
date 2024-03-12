import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';

import '../../receipts/widgets/quick_scan.dart';
import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(context) {
  return IconButton(
    icon: const Icon(Icons.add_a_photo),
    onPressed: () async {
      // TODO: finish implementing this
      scanImagesMultiPart(1);
    },
  );
}

showQuickScanBottomSheet(context) {
  List<Widget> actions = [_getUploadIcon(context)];

  showFullscreenBottomSheet(context, const QuickScan(), "Quick Scan",
      actions: actions);
}
