import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';

Future<List<String>> scanImages(int numberOfPages) async {
  return await CunningDocumentScanner.getPictures(noOfPages: numberOfPages) ??
      [];
}

Future<List<UploadMultipartFileData>> scanImagesMultiPart(
    int numberOfPages) async {
  var files = <UploadMultipartFileData>[];
  var filePaths =
      await CunningDocumentScanner.getPictures(noOfPages: numberOfPages);

  if (filePaths!.isEmpty) {
    return files;
  }

  for (var filePath in filePaths) {
    var multipartFile = await MultipartFile.fromPath("file", filePath);
    var bytes = await File(filePath).readAsBytes();

    files.add(UploadMultipartFileData(file: multipartFile, bytes: bytes));
  }

  return files;
}
