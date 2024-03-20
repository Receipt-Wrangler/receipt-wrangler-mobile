import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan_form.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

import '../../interfaces/upload_multipart_file_data.dart';

class QuickScan extends StatefulWidget {
  const QuickScan(
      {super.key, required this.formKey, required this.imageStream});

  final Stream<UploadMultipartFileData?> imageStream;

  final GlobalKey<FormBuilderState> formKey;

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  late InfiniteScrollController controller;
  List<UploadMultipartFileData> images = [];

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
                formKey: widget.formKey,
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
