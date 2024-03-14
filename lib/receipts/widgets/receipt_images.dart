import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_image_carousel.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';

class ReceiptImages extends StatefulWidget {
  const ReceiptImages({super.key});

  @override
  State<ReceiptImages> createState() => _ReceiptImages();
}

class _ReceiptImages extends State<ReceiptImages> {
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
    var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
    var future = getReceiptImageFutures(receipt);
    return FutureBuilder(
        key: UniqueKey(),
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ReceiptImageCarousel(
                key: UniqueKey(),
                images: snapshot.data ?? [],
                receipt: receipt,
              ),
            );
          } else {
            return const CircularLoadingProgress();
          }
        });
  }
}
