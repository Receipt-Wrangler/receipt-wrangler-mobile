import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:rxdart/rxdart.dart';

import '../../api.dart' as api;
import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

class ReceiptImageScreen extends StatefulWidget {
  const ReceiptImageScreen({super.key});

  @override
  State<ReceiptImageScreen> createState() => _ReceiptImageScreen();
}

class _ReceiptImageScreen extends State<ReceiptImageScreen> {
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;
  late final future = getReceiptImageFutures(receipt);
  late final formState = getFormStateFromContext(context);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  var isLoadingBehaviorSubject = BehaviorSubject<bool>();

  @override
  void initState() {
    super.initState();
    isLoadingBehaviorSubject.add(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    future.then((value) {
      receiptModel.imageBehaviorSubject.add(value);
      isLoadingBehaviorSubject.add(false);
    }).catchError((err) {
      isLoadingBehaviorSubject.add(false);
      return err;
    });
  }

  Future<List<api.FileDataView?>> getReceiptImageFutures(api.Receipt receipt) {
    if (formState == WranglerFormState.add) {
      return Future.wait([]);
    } else {
      List<Future<api.FileDataView?>> imageFutures = [];

      return api.ReceiptApi().getReceiptById(receipt.id).then((receipt) {
        for (var image in receipt?.imageFiles ?? []) {
          imageFutures.add(api.ReceiptImageApi().getReceiptImageById(image.id));
        }

        return Future.wait(imageFutures);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isLoadingBehaviorSubject.stream,
        builder: (context, snapshot) {
          Widget widget = ReceiptImages(
            imageStream: receiptModel.imageBehaviorSubject.stream,
            infiniteScrollController: receiptModel.infiniteScrollController,
          );

          if (snapshot.hasData && snapshot.data == true) {
            widget = const Center(child: CircularProgressIndicator());
          }

          return widget;
        });
  }
}
