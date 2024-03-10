import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_image_carousel.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';

class ReceiptImages extends StatefulWidget {
  const ReceiptImages({super.key, required this.receipt});

  final api.Receipt receipt;

  @override
  State<ReceiptImages> createState() => _ReceiptImages();
}

class _ReceiptImages extends State<ReceiptImages> {
  Future<List<api.FileDataView?>> getReceiptImageFutures() {
    List<Future<api.FileDataView?>> imageFutures = [];

    return api.ReceiptApi().getReceiptById(widget.receipt.id).then((receipt) {
      for (var image in receipt?.imageFiles ?? []) {
        imageFutures.add(api.ReceiptImageApi().getReceiptImageById(image.id));
      }

      return Future.wait(imageFutures);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ReceiptModel>(context, listen: true);
    var future = getReceiptImageFutures();
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
                receipt: widget.receipt,
              ),
            );
          } else {
            return const CircularLoadingProgress();
          }
        });
  }
}
