import 'dart:io';

import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';

Future<List<FileDataView>> uploadImagesToReceipt(String receiptId) async {
  try {
    // TODO: pass back the file data views, then add them to receipt via receipt provider. We can use an images array stream, then set up a listener in the carousel
    List<FileDataView> filesUploaded = [];
    var filePaths = await scanImages(5) ?? [];
    for (var filePath in filePaths) {
      var multipartFile = await MultipartFile.fromPath("file", filePath);
      var fileDataView = await ReceiptImageApi()
          .uploadReceiptImage(multipartFile, int.parse(receiptId));
      filesUploaded.add(fileDataView as FileDataView);
      await File(filePath).delete();
    }
    return filesUploaded;
  } catch (e) {
    print(e);
    return [];
  }
}
