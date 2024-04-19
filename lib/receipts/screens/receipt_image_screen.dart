import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_images.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
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

  Future<List<api.FileDataView?>> getReceiptImageFutures(api.Receipt receipt) {
    List<Future<api.FileDataView?>> imageFutures = [];

    return api.ReceiptApi().getReceiptById(receipt.id).then((receipt) {
      for (var image in receipt?.imageFiles ?? []) {
        imageFutures.add(api.ReceiptImageApi().getReceiptImageById(image.id));
      }

      return Future.wait(imageFutures);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            imageBehaviorSubject.add(snapshot.data as List<api.FileDataView?>);
            return ScreenWrapper(
                appBarWidget: ReceiptAppBar(),
                bodyPadding: const EdgeInsets.all(0),
                bottomNavigationBarWidget: const ReceiptBottomNav(),
                child: ReceiptImages(
                  imageStream: imageBehaviorSubject.stream,
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
