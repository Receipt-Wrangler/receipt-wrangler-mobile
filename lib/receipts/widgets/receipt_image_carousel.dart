import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;

class ReceiptImageCarousel extends StatefulWidget {
  const ReceiptImageCarousel({
    super.key,
    required this.images,
  });

  final List<api.FileDataView?> images;

  @override
  State<ReceiptImageCarousel> createState() => _ReceiptImageCarousel();
}

class _ReceiptImageCarousel extends State<ReceiptImageCarousel> {
  late InfiniteScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Image getDecodedImage(int index) {
      var image = widget.images[index];
      if (image?.encodedImage == null) {
        // TODO: add placeholder. This should never happen though
        return Image.asset("assets/images/placeholder.png");
      } else {
        var base64Image = image?.encodedImage.split(",").last;
        var bytes = base64Decode(base64Image!);

        return Image.memory(bytes);
      }
    }

    return InfiniteCarousel.builder(
      itemCount: widget.images.length,
      itemExtent: 120,
      center: false,
      anchor: 0.0,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: controller,
      axisDirection: Axis.vertical,
      loop: false,
      itemBuilder: (context, itemIndex, realIndex) {
        return getDecodedImage(itemIndex);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
