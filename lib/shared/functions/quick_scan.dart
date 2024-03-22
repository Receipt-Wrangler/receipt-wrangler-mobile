import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan.dart';
import 'package:receipt_wrangler_mobile/shared/classes/quick_scan_image.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../../interfaces/upload_multipart_file_data.dart';
import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(
    context, StreamController<UploadMultipartFileData?> streamController) {
  return IconButton(
    icon: const Icon(Icons.add_a_photo),
    onPressed: () async {
      var uploadedImages = await scanImagesMultiPart(100);
      if (uploadedImages.isNotEmpty) {
        for (var image in uploadedImages) {
          var quickScanImage =
              QuickScanImage.fromUploadMultipartFileData(image);
          streamController.add(quickScanImage);
        }
      }
    },
  );
}

Widget _getGalleryUploadImage(
    context, StreamController<UploadMultipartFileData?> streamController) {
  return IconButton(
    icon: const Icon(Icons.upload_file_rounded),
    onPressed: () async {
      var uploadedImages = await getGalleryImages();
      if (uploadedImages.isNotEmpty) {
        for (var image in uploadedImages) {
          var quickScanImage =
              QuickScanImage.fromUploadMultipartFileData(image);
          streamController.add(quickScanImage);
        }
      }
    },
  );
}

Widget _getSubmitButton(
    BuildContext context, StreamController<QuickScanImage> streamController) {
  List<QuickScanImage>? images = [];
  streamController.stream.listen((event) {
    images.add(event);
  });
  return BottomSubmitButton(
    onPressed: () async {
      await _submitQuickScan(context, images);
    },
  );
}

Future<void> _submitQuickScan(
    BuildContext context, List<QuickScanImage> images) async {
  List<int> groupIds = [];
  List<int> paidByUserIds = [];
  List<api.ReceiptStatus> statuses = [];
  List<MultipartFile> files = [];

  if (images.isEmpty) {
    showErrorSnackbar(context, "Please upload at least one image");
    return;
  }

  for (var image in images) {
    if (image.formKey.currentState!.saveAndValidate()) {
      var form = image.formKey.currentState!.value;
      files.add(image.multipartFile);
      groupIds.add(form["groupId"]);
      paidByUserIds.add(form["paidByUserId"]);
      statuses.add(form["status"]);
    }
  }

  try {
    setLoadingBarState(context, true);
    var receipts = await api.ReceiptApi()
        .quickScanReceipt(files, groupIds, paidByUserIds, statuses);
    setLoadingBarState(context, false);
    showSuccessSnackbar(
      context,
      "Quick scan successfully uploaded ${receipts?.length} receipts",
    );
  } catch (e) {
    print(e);
    showApiErrorSnackbar(context, e as dynamic);
    setLoadingBarState(context, false);
    return;
  }

  return;
}

showQuickScanBottomSheet(context) {
  StreamController<QuickScanImage> streamController =
      StreamController.broadcast();

  List<Widget> actions = [
    _getUploadIcon(context, streamController),
    _getGalleryUploadImage(context, streamController)
  ];

  showFullscreenBottomSheet(
      context,
      QuickScan(
        imageStream: streamController.stream,
      ),
      "Quick Scan",
      actions: actions,
      bodyPadding: EdgeInsets.zero,
      bottomSheetWidget: _getSubmitButton(context, streamController));
}

// TODO: Now we have all of the forms using different keys, we have the carasoul rendering right
// We need to submit the forms by taking each key, saving, validating and then smashing all the data together in the correct format
// Then finally submitting all of this data.
// Then we need to disable the submit button while the form is submitting
// Lastly, we need to double check scanner to make sure it will support multiple files
// Then we need to show error messages upon validation errors!
