import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';

class QuickScanImage extends UploadMultipartFileData {
  QuickScanImage(
      {required this.multipartFile, required this.bytes, required this.formKey})
      : super(multipartFile: multipartFile, bytes: bytes);

  final MultipartFile multipartFile;

  final Uint8List bytes;

  final GlobalKey<FormBuilderState> formKey;

  static QuickScanImage fromUploadMultipartFileData(
      UploadMultipartFileData data) {
    return QuickScanImage(
        multipartFile: data.multipartFile,
        bytes: data.bytes,
        formKey: GlobalKey<FormBuilderState>());
  }
}
