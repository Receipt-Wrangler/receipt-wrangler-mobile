import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

import '../../models/receipt_model.dart';

class ReceiptImageCarousel extends StatefulWidget {
  const ReceiptImageCarousel(
      {super.key, required this.images, required this.receipt});

  final List<api.FileDataView?> images;

  final api.Receipt receipt;

  @override
  State<ReceiptImageCarousel> createState() => _ReceiptImageCarousel();
}

class _ReceiptImageCarousel extends State<ReceiptImageCarousel> {
  late InfiniteScrollController controller;
  late StreamSubscription<api.FileDataView> streamListener;
  List<api.FileDataView?> _images = [];

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
    _images = [...widget.images];
    var receiptImageStream =
        Provider.of<ReceiptModel>(context, listen: false).imagesStream;
    streamListener = receiptImageStream.listen((event) {
      setState(() {
        _images = [..._images, event];
        controller = InfiniteScrollController();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildNameField(int index) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Name",
        ),
        initialValue: _images[index]?.name ?? "",
        readOnly: true,
      );
    }

    Widget buildDateAddedField(int index) {
      var formattedDate = formatDate(
          defaultDateFormat, DateTime.parse(_images[index]?.createdAt ?? ""));
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Date Added",
        ),
        initialValue: formattedDate,
        readOnly: true,
      );
    }

    Image getDecodedImage(int index) {
      var image = _images[index];
      if (image?.encodedImage == null) {
        // TODO: add placeholder. This should never happen though
        return Image.asset("assets/images/placeholder.png");
      } else {
        var base64Image = image?.encodedImage.split(",").last;
        var bytes = base64Decode(base64Image!);

        return Image.memory(bytes);
      }
    }

    Widget getImageWidget(int index) {
      var bottomPosition = MediaQuery.of(context).size.height * .0001;
      return Stack(children: [
        Center(child: getDecodedImage(index)),
/*        Positioned(
            bottom: bottomPosition,
            left: 4,
            child: IconButton(icon: const Icon(Icons.more), onPressed: () {}))*/
      ]);
    }

    Widget buildInfiniteCarousel() {
      if (_images.isEmpty) {
        return const Center(child: Text("No images found"));
      } else {
        return InfiniteCarousel.builder(
          itemCount: _images.length,
          itemExtent: MediaQuery.of(context).size.width,
          center: false,
          velocityFactor: 0.2,
          onIndexChanged: (index) {},
          controller: controller,
          axisDirection: Axis.horizontal,
          loop: false,
          itemBuilder: (context, itemIndex, realIndex) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getImagePreviewHeight(context),
                  width: getImagePreviewWidth(context),
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: getImageWidget(realIndex),
                ),
                Padding(
                  padding: getImageDataPadding(),
                  child: Column(children: [
                    buildNameField(realIndex),
                    textFieldSpacing,
                    buildDateAddedField(realIndex),
                  ]),
                ),
              ],
            );
          },
        );
      }
    }

    return buildInfiniteCarousel();
  }

  @override
  void dispose() {
    super.dispose();
    streamListener.cancel();
  }
}
