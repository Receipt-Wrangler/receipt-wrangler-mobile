import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class ReceiptImageCarousel extends StatefulWidget {
  const ReceiptImageCarousel({
    super.key,
    this.images,
    this.imagesToUpload,
    this.infiniteScrollController,
  });

  final List<api.FileDataView?>? images;

  final List<UploadMultipartFileData>? imagesToUpload;

  final infiniteScrollController;

  final encodedImages = true;

  @override
  State<ReceiptImageCarousel> createState() => _ReceiptImageCarousel();
}

class _ReceiptImageCarousel extends State<ReceiptImageCarousel> {
  late final controller =
      widget.infiniteScrollController ?? InfiniteScrollController();

  int getAdjustedIndex(int index) {
    var isImagesEmpty = (widget.images ?? []).isEmpty;

    if (isImageFromApi(index)) {
      return index;
    } else {
      if (isImagesEmpty) {
        return index;
      }

      return index - (widget.images?.length ?? 0);
    }
  }

  bool isImageFromApi(int index) {
    return index <= (widget.images ?? []).length - 1;
  }

  Widget buildNameField(int index) {
    var initialValue = "";
    if (isImageFromApi(index)) {
      initialValue = widget.images![index]?.name ?? "";
    } else {
      initialValue = widget.imagesToUpload![getAdjustedIndex(index)]
              .multipartFile.filename ??
          "";
    }

    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Name",
      ),
      initialValue: initialValue,
      readOnly: true,
    );
  }

  Widget buildDateAddedField(int index) {
    if (isImageFromApi(index)) {
      var formattedDate = formatDate(defaultDateFormat,
          DateTime.parse(widget.images![index]?.createdAt ?? ""));
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Date Added",
        ),
        initialValue: formattedDate,
        readOnly: true,
      );
    }

    return const SizedBox.shrink();
  }

  Image getDecodedImage(int index) {
    var image = widget.images?[index];
    if (image?.encodedImage == null) {
      // TODO: add placeholder. This should never happen though
      return Image.asset("assets/images/placeholder.png");
    } else {
      var base64Image = image?.encodedImage.split(",").last;
      var bytes = base64Decode(base64Image!);

      return Image.memory(bytes);
    }
  }

  Widget getInMemoryImage(int index) {
    var indexToUse = index;
    if ((widget.images ?? []).isNotEmpty) {
      indexToUse = index - (widget.images!.length - 1);
    }

    var image = widget.imagesToUpload![indexToUse];
    return Image.memory(image.bytes);
  }

  Widget getImage(int index) {
    if (index <= (widget.images ?? []).length - 1) {
      return getDecodedImage(index);
    } else {
      return getInMemoryImage(index);
    }
  }

  Widget getImageWidget(int index) {
    var bottomPosition = MediaQuery.of(context).size.height * .0001;

    return Stack(children: [
      Center(child: getImage(index)),
/*        Positioned(
            bottom: bottomPosition,
            left: 4,
            child: IconButton(icon: const Icon(Icons.more), onPressed: () {}))*/
    ]);
  }

  Widget buildInfiniteCarousel() {
    if ((widget.images ?? []).isEmpty &&
        (widget.imagesToUpload ?? []).isEmpty) {
      return const Center(child: Text("No images found"));
    }

    var imagesCount = widget.images?.length ?? 0;
    var imagesToUploadCount = widget.imagesToUpload?.length ?? 0;

    return InfiniteCarousel.builder(
      itemCount: imagesCount + imagesToUploadCount,
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

  @override
  Widget build(BuildContext context) {
    return buildInfiniteCarousel();
  }
}
