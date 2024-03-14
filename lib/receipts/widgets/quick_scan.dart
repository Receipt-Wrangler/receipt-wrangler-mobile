import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/quick_scan_form.dart';

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
  Widget _buildImagePreview() {
    return StreamBuilder<UploadMultipartFileData?>(
      stream: widget.imageStream,
      builder: (BuildContext context,
          AsyncSnapshot<UploadMultipartFileData?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(snapshot.data?.bytes as Uint8List);
        }
        return const Text("Select an image to scan.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImagePreview(),
        QuickScanForm(
          formKey: widget.formKey,
        ),
      ],
    );
  }
}
