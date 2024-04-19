import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_edit_popup_menu.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/receipt_model.dart';
import '../nav/receipt_bottom_nav.dart';

class ReceiptImageScreen extends StatefulWidget {
  const ReceiptImageScreen({super.key});

  @override
  State<ReceiptImageScreen> createState() => _ReceiptImageScreen();
}

class _ReceiptImageScreen extends State<ReceiptImageScreen> {
  final imageBehaviorSubject = BehaviorSubject<List<api.FileDataView?>>();
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;
  late final future = getReceiptImageFutures(receipt);
  late final formState = getFormStateFromContext(context);
  var isLoadingBehaviorSubject = BehaviorSubject<bool>();

  @override
  void initState() {
    super.initState();
    isLoadingBehaviorSubject.add(true);
    future.then((value) {
      imageBehaviorSubject.add(value);
      isLoadingBehaviorSubject.add(false);
    }).catchError((err) {
      isLoadingBehaviorSubject.add(false);
      return err;
    });
  }

  Future<List<api.FileDataView?>> getReceiptImageFutures(api.Receipt receipt) {
    List<Future<api.FileDataView?>> imageFutures = [];

    return api.ReceiptApi().getReceiptById(receipt.id).then((receipt) {
      for (var image in receipt?.imageFiles ?? []) {
        imageFutures.add(api.ReceiptImageApi().getReceiptImageById(image.id));
      }

      return Future.wait(imageFutures);
    });
  }

  Widget buildViewAppBarMenu() {
    return ReceiptEditPopupMenu(groupId: receipt.groupId, popupMenuChildren: [
      PopupMenuItem(
          value: "edit",
          child: const Text("Edit"),
          onTap: () => context.go("/receipts/${receipt.id}/images/edit")),
    ]);
  }

  buildEditAppBarMenu() {
    return ReceiptEditPopupMenu(groupId: receipt.groupId, popupMenuChildren: [
      buildUploadFromGalleryButton(),
      buildDeleteButton(),
    ]);
  }

  PopupMenuEntry buildDeleteButton() {
    return PopupMenuItem(
      child: const Text("Delete Image"),
      value: "delete",
      onTap: () async => await deleteImage(),
    );
  }

  deleteImage() async {
    try {
      // TODO: get index from scroll controller
      var index = 0;
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
        value: "upload",
        child: const Text("Upload from Gallery"),
        onTap: () async => await uploadFromGallery());
  }

  uploadFromGallery() async {
    try {
      var successMessage = "Successfully uploaded image";

      var imagesToUpload = await getGalleryImages(multiple: false);
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

  List<Widget> buildAppBarActions() {
    switch (formState) {
      case WranglerFormState.view:
        return [buildViewAppBarMenu()];
      case WranglerFormState.edit:
        return [buildEditAppBarMenu()];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isLoadingBehaviorSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return const Center(child: CircularProgressIndicator());
          }

          return ScreenWrapper(
              appBarWidget: ReceiptAppBar(actions: buildAppBarActions()),
              bodyPadding: const EdgeInsets.all(0),
              bottomNavigationBarWidget: const ReceiptBottomNav(),
              child: ReceiptImages(
                imageStream: imageBehaviorSubject.stream,
              ));
        });
  }
}
