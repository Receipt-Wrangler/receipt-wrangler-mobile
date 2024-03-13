import 'dart:typed_data';

import 'package:http/http.dart';

class UploadMultipartFileData {
  MultipartFile file;
  Uint8List bytes;

  UploadMultipartFileData({required this.file, required this.bytes});
}
