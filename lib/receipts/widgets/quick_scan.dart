import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan_form.dart';

class QuickScan extends StatefulWidget {
  const QuickScan(
      {super.key, required this.formKey, required this.imageStream});

  final Stream<MultipartFile?> imageStream;

  final GlobalKey<FormBuilderState> formKey;

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  Widget _buildImagePreview() {
    if (bytes != null) {
      return Image.memory(bytes as Uint8List);
    }

    if (image != null) {
      var byteFuture = image!.finalize().toBytes();
      return FutureBuilder(
          future: byteFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bytes = snapshot.data;
              return Image.memory(snapshot.data as Uint8List);
            }
            return const CircularProgressIndicator();
          });
    }
    return const Text("Select an image to scan.");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImagePreview(),
        QuickScanForm(
          formKey: widget.formKey,
          imageStream: Stream<MultipartFile?>.empty(),
        ),
      ],
    );
  }
}
