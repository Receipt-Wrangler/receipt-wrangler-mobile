import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_edit_popup_menu.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/receipt_model.dart';
import '../nav/receipt_bottom_nav.dart';

class ReceiptImageScreenView extends StatefulWidget {
  const ReceiptImageScreenView({super.key});

  @override
  State<ReceiptImageScreenView> createState() => _ReceiptImageScreenView();
}

class _ReceiptImageScreenView extends State<ReceiptImageScreenView> {
  final imageBehaviorSubject = BehaviorSubject<List<api.FileDataView?>>();
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;
  late final future = getReceiptImageFutures(receipt);
  late final formState = getFormStateFromContext(context);
  var isLoadingBehaviorSubject = BehaviorSubject<bool>();
  final controller = InfiniteScrollController();

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

  List<PopupMenuEntry> buildViewAppBarMenuOptions() {
    return [
      PopupMenuItem(
          value: "edit",
          child: const Text("Edit"),
          onTap: () => context.go("/receipts/${receipt.id}/images/edit")),
    ];
  }

  Widget buildAppBarMenu() {
    return ReceiptEditPopupMenu(
        groupId: receipt.groupId,
        popupMenuChildren: buildViewAppBarMenuOptions());
  }

  @override
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
