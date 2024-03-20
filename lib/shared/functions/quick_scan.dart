import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/loading_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_submit_button.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../../interfaces/upload_multipart_file_data.dart';
import '../../utils/bottom_sheet.dart';

Widget _getUploadIcon(
    context, StreamController<UploadMultipartFileData?> streamController) {
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

Widget _getGalleryUploadImage(
    context, StreamController<UploadMultipartFileData?> streamController) {
  return IconButton(
    icon: const Icon(Icons.upload_file),
    onPressed: () async {
      var uploadedImages = await getGalleryImages();
      if (uploadedImages.isNotEmpty) {
        for (var image in uploadedImages) {
          streamController.add(image);
        }
      }
    },
  );
}

Widget _getSubmitButton(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
    StreamController<UploadMultipartFileData?> streamController) {
  UploadMultipartFileData? image;
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
    GlobalKey<FormBuilderState> formKey, UploadMultipartFileData? image) async {
  if (image != null && formKey.currentState!.saveAndValidate()) {
    var form = formKey.currentState!.value;
    try {
      Provider.of<LoadingModel>(context, listen: false).setIsLoading(true);
      var receipt = await api.ReceiptApi().quickScanReceipt(
          [image.multipartFile],
          form["groupId"],
          form["paidByUserId"],
          form["status"]) as api.Receipt;
      Provider.of<LoadingModel>(context, listen: false).setIsLoading(false);
      showSuccessSnackbar(context, "Quick scan successfully uploaded",
          action: _getSuccessSnackBarActionWidget(context, receipt));
    } catch (e) {
      print(e);
      showApiErrorSnackbar(context, e as dynamic);
      Provider.of<LoadingModel>(context, listen: false).setIsLoading(false);
      return;
    }
  }

  return;
}

_getSuccessSnackBarActionWidget(BuildContext context, api.Receipt receipt) {
  return SnackBarAction(
    label: "View Receipt",
    onPressed: () {
      context.go("/receipts/${receipt.id}/view");
    },
  );
}

showQuickScanBottomSheet(context) {
  StreamController<UploadMultipartFileData?> streamController =
      StreamController.broadcast();

  List<Widget> actions = [
    _getUploadIcon(context, streamController),
    _getGalleryUploadImage(context, streamController)
  ];
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
