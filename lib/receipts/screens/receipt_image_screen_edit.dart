import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/enums/upload_method.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_image_screen_base.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_edit_popup_menu.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import '../nav/receipt_bottom_nav.dart';

class ReceiptImageScreenEdit extends ReceiptImageScreenBase {
  const ReceiptImageScreenEdit({super.key});

  @override
  State<ReceiptImageScreenEdit> createState() => _ReceiptImageScreenEdit();
}

class _ReceiptImageScreenEdit
    extends ReceiptImageScreenBaseState<ReceiptImageScreenEdit> {
  List<PopupMenuEntry> buildEditAppBarMenuOptions() {
    return [
      buildUploadFromCameraButton(),
      buildUploadFromGalleryButton(),
      buildDeleteButton(),
    ];
  }

  PopupMenuEntry buildDeleteButton() {
    return PopupMenuItem(
      child: const Text("Delete Image"),
      value: "delete",
      onTap: () async => await deleteImage(),
    );
  }

  Future<void> deleteImage() async {
    try {
      var index = controller.selectedItem;
      await api.ReceiptImageApi()
          .deleteReceiptImageById(imageBehaviorSubject.value[index]!.id);
      var currentImages =
          List<api.FileDataView?>.from(imageBehaviorSubject.value);
      currentImages.removeAt(index);
      imageBehaviorSubject.add(currentImages);

      showSuccessSnackbar(context, "Successfully deleted image");
    } catch (e) {
      showApiErrorSnackbar(context, e as api.ApiException);
    }
  }

  PopupMenuEntry buildUploadFromGalleryButton() {
    return PopupMenuItem(
        value: "gallery",
        child: const Text("Upload from Gallery"),
        onTap: () async => await uploadImages(UploadMethod.gallery));
  }

  PopupMenuEntry buildUploadFromCameraButton() {
    return PopupMenuItem(
        value: "camera",
        child: const Text("Upload from Camera"),
        onTap: () async => await uploadImages(UploadMethod.camera));
  }

  Future<void> uploadImages(UploadMethod method) async {
    try {
      var successMessage = "Successfully uploaded image";
      List<UploadMultipartFileData> imagesToUpload;

      if (method == UploadMethod.camera) {
        imagesToUpload = await scanImagesMultiPart(1);
      } else {
        imagesToUpload = await getGalleryImages(multiple: false);
      }

      for (var image in imagesToUpload) {
        var uploadedImage = await api.ReceiptImageApi()
            .uploadReceiptImage(image.multipartFile, receipt.id);
        var oldImages =
            List<api.FileDataView?>.from(imageBehaviorSubject.value);
        oldImages.add(uploadedImage);
        imageBehaviorSubject.add(oldImages);
      }

      if (imagesToUpload.isEmpty) {
        return;
      }
      if (imagesToUpload.length > 1) {
        successMessage =
            "Successfully uploaded ${imagesToUpload.length} images";
        return;
      }

      showSuccessSnackbar(context, successMessage);
    } catch (e) {
      showApiErrorSnackbar(context, e as api.ApiException);
    }
  }

  Widget buildAppBarMenu() {
    return ReceiptEditPopupMenu(
        groupId: receipt.groupId,
        popupMenuChildren: buildEditAppBarMenuOptions());
  }

  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isLoadingBehaviorSubject.stream,
        builder: (context, snapshot) {
          Widget widget = ReceiptImages(
            imageStream: imageBehaviorSubject.stream,
            infiniteScrollController: controller,
          );

          if (snapshot.hasData && snapshot.data == true) {
            widget = const Center(child: CircularProgressIndicator());
          }

          return ScreenWrapper(
              appBarWidget: ReceiptAppBar(actions: [buildAppBarMenu()]),
              bodyPadding: const EdgeInsets.all(0),
              bottomNavigationBarWidget: const ReceiptBottomNav(),
              child: widget);
        });
  }
}
