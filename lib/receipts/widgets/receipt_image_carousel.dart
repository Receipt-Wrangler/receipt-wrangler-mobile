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
      itemExtent: MediaQuery.of(context).size.width,
      center: true,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: controller,
      axisDirection: Axis.horizontal,
      loop: false,
      itemBuilder: (context, itemIndex, realIndex) {
        return InteractiveViewer(
          minScale: 0.1,
          maxScale: 50.0,
          child: getDecodedImage(realIndex),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
