import 'dart:typed_data';

import 'package:http/http.dart';

class UploadMultipartFileData {
  MultipartFile multipartFile;
  Uint8List bytes;

  UploadMultipartFileData({required this.multipartFile, required this.bytes});
}
