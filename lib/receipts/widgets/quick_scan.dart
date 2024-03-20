import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan_form.dart';
import 'package:receipt_wrangler_mobile/shared/classes/quick_scan_image.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

class QuickScan extends StatefulWidget {
  const QuickScan({super.key, required this.imageStream});

  final Stream<QuickScanImage> imageStream;

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  late InfiniteScrollController controller;
  List<QuickScanImage> images = [];

  @override
  void initState() {
    super.initState();

    controller = InfiniteScrollController();
    widget.imageStream.listen((event) {
      setState(() {
        if (event != null) {
          images = [...images, event];
        }
      });
    });
  }

  Widget _buildImagePreview(int index) {
    return SizedBox(
      height: getImagePreviewHeight(context),
      width: getImagePreviewWidth(context),
      child: Image.memory(images[index].bytes),
    );
  }

  Widget _buildCarousel() {
    return InfiniteCarousel.builder(
      itemCount: images.length,
      itemExtent: MediaQuery.of(context).size.width,
      center: false,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: controller,
      axisDirection: Axis.horizontal,
      loop: false,
      itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
        return Column(
          children: [
            _buildImagePreview(realIndex),
            Padding(
              padding: getImageDataPadding(),
              child: QuickScanForm(
                formKey: images[realIndex].formKey,
                index: realIndex,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.length == 0) {
      return const Center(
        child: Text("No images to display"),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _buildCarousel(),
    );
  }
}
