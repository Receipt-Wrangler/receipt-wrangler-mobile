import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_image_carousel.dart';

class ReceiptImages extends StatefulWidget {
  const ReceiptImages(
      {super.key,
      required this.imageStream,
      required this.infiniteScrollController});

  final Stream<List<api.FileDataView?>> imageStream;

  final InfiniteScrollController infiniteScrollController;

  @override
  State<ReceiptImages> createState() => _ReceiptImages();
}

class _ReceiptImages extends State<ReceiptImages> {
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.imageStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ReceiptImageCarousel(
              key: UniqueKey(),
              images: snapshot.data as List<api.FileDataView?>,
              infiniteScrollController: widget.infiniteScrollController,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
