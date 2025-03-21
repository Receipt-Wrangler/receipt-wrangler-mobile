import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan_form.dart';
import 'package:receipt_wrangler_mobile/shared/classes/quick_scan_image.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/image_viewer.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';
import 'package:rxdart/rxdart.dart';

class QuickScan extends StatefulWidget {
  const QuickScan(
      {super.key,
      required this.imageSubject,
      required this.infiniteScrollController});

  final BehaviorSubject<List<QuickScanImage>> imageSubject;

  final InfiniteScrollController infiniteScrollController;

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  Widget _buildImagePreview(int index) {
    var image = Image.memory(widget.imageSubject.value[index].bytes);
    return SizedBox(
        height: getImagePreviewHeight(context),
        width: getImagePreviewWidth(context),
        child: ImageViewer(image: image));
  }

  Widget _buildCarousel() {
    return InfiniteCarousel.builder(
      itemCount: widget.imageSubject.value.length,
      itemExtent: MediaQuery.of(context).size.width,
      center: false,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: widget.infiniteScrollController,
      axisDirection: Axis.horizontal,
      loop: false,
      itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildImagePreview(realIndex),
              Padding(
                padding: getImageDataPadding(),
                child: QuickScanForm(
                  formKey: widget.imageSubject.value[realIndex].formKey,
                  image: widget.imageSubject.value[realIndex],
                  index: realIndex,
                  onDeactivateCallback: (groupId, paidByUserId, status) {
                    var newImage = widget.imageSubject.value[realIndex];
                    newImage.groupId = groupId;
                    newImage.paidByUserId = paidByUserId;
                    newImage.status = status;

                    var newImages = widget.imageSubject.value;

                    newImages[realIndex] = newImage;
                    widget.imageSubject.add(newImages);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.imageSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Scan or upload an image to get started"),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _buildCarousel(),
            );
          }

          return SizedBox.shrink();
        });
  }
}
