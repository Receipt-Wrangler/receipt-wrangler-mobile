import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan.dart';
import 'package:receipt_wrangler_mobile/shared/classes/quick_scan_image.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/delete_button.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(
    context, BehaviorSubject<List<QuickScanImage>> imageSubject) {
  return IconButton(
    icon: const Icon(Icons.add_a_photo),
    onPressed: () async {
      var uploadedImages = await scanImagesMultiPart(100);
      if (uploadedImages.isNotEmpty) {
        List<QuickScanImage> quickScanImages = [];
        for (var image in uploadedImages) {
          var quickScanImage =
              QuickScanImage.fromUploadMultipartFileData(image);
          quickScanImages.add(quickScanImage);
        }
        imageSubject.add(imageSubject.value + quickScanImages);
      }
    },
  );
}

Widget _getGalleryUploadImage(
    context, BehaviorSubject<List<QuickScanImage>> imageSubject) {
  return IconButton(
    icon: const Icon(Icons.upload_file_rounded),
    onPressed: () async {
      var uploadedImages = await getGalleryImages();
      if (uploadedImages.isNotEmpty) {
        List<QuickScanImage> quickScanImages = [];
        for (var image in uploadedImages) {
          var quickScanImage =
              QuickScanImage.fromUploadMultipartFileData(image);
          quickScanImages.add(quickScanImage);
        }

        imageSubject.add(imageSubject.value + quickScanImages);
      }
    },
  );
}

Widget _getSubmitButton(
    BuildContext context, BehaviorSubject<List<QuickScanImage>> imageSubject) {
  return BottomSubmitButton(
    onPressed: () async {
      await _submitQuickScan(context, imageSubject.value);
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

Widget _getDeleteIcon(InfiniteScrollController infiniteScrollController,
    BehaviorSubject<List<QuickScanImage>> imageSubject) {
  return StreamBuilder<List<QuickScanImage>>(
    stream: imageSubject.stream,
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return DeleteButton(
          onPressed: () {
            var images = imageSubject.value;
            images.removeAt(infiniteScrollController.selectedItem);
            imageSubject.add(images);
          },
        );
      } else {
        return const SizedBox();
      }
    },
  );
}

showQuickScanBottomSheet(context) {
  var infiniteScrollController = InfiniteScrollController();
  BehaviorSubject<List<QuickScanImage>> imageSubject =
      BehaviorSubject<List<QuickScanImage>>.seeded([]);

  List<Widget> actions = [
    _getUploadIcon(context, imageSubject),
    _getGalleryUploadImage(context, imageSubject),
    _getDeleteIcon(infiniteScrollController, imageSubject),
  ];

  showFullscreenBottomSheet(
      context,
      QuickScan(
        imageSubject: imageSubject,
        infiniteScrollController: infiniteScrollController,
      ),
      "Quick Scan",
      actions: actions,
      bodyPadding: EdgeInsets.zero,
      bottomSheetWidget: _getSubmitButton(context, imageSubject));
}
