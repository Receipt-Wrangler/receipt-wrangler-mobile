import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

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

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildNameField(int index) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Name",
        ),
        initialValue: widget.receipt.imageFiles[index].name,
        readOnly: true,
      );
    }

    Widget buildDateAddedField(int index) {
      var formattedDate = formatDate(defaultDateFormat,
          DateTime.parse(widget.receipt.imageFiles[index].createdAt ?? ""));
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Date Added",
        ),
        initialValue: formattedDate,
        readOnly: true,
      );
    }

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

    Widget getImageWidget(int index) {
      var bottomPosition = MediaQuery.of(context).size.height * .0001;
      return Stack(children: [
        Center(child: getDecodedImage(index)),
        Positioned(
            bottom: bottomPosition,
            left: 4,
            child: IconButton(icon: const Icon(Icons.more), onPressed: () {}))
      ]);
    }

    Widget buildInfiniteCarousel() {
      if (widget.images.isEmpty) {
        return const Center(child: Text("No images found"));
      } else {
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
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: getImageWidget(realIndex),
                ),
                Padding(
                  padding: const EdgeInsets.all(26),
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
    controller.dispose();
  }
}
