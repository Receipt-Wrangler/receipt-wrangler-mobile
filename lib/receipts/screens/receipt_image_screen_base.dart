import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../api.dart' as api;
import '../../models/receipt_model.dart';
import '../../utils/forms.dart';

abstract class ReceiptImageScreenBase extends StatefulWidget {
  const ReceiptImageScreenBase({Key? key}) : super(key: key);

  @override
  State<ReceiptImageScreenBase> createState();
}

abstract class ReceiptImageScreenBaseState<T extends ReceiptImageScreenBase>
    extends State<T> {
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
    future.then((value) {
      receiptModel.imageBehaviorSubject.add(value);
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
}
