import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_image_carousel.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';

class ReceiptImages extends StatefulWidget {
  const ReceiptImages({
    super.key,
  });

  @override
  State<ReceiptImages> createState() => _ReceiptImages();
}

class _ReceiptImages extends State<ReceiptImages> {
  Future<List<api.FileDataView?>> getReceiptImageFutures() {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    List<Future<api.FileDataView?>> imageFutures = [];

    for (var image in receiptModel.receipt.imageFiles) {
      imageFutures.add(api.ReceiptImageApi().getReceiptImageById(image.id));
    }

    return Future.wait(imageFutures);
  }

  @override
  Widget build(BuildContext context) {
    var future = getReceiptImageFutures();
    return FutureBuilder(
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
                images: snapshot.data ?? [],
              ),
            );
          } else {
            return const CircularLoadingProgress();
          }
        });
  }
}
