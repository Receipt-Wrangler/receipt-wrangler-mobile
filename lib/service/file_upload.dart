import 'package:receipt_wrangler_mobile/api.dart';
import 'package:receipt_wrangler_mobile/utils/scan.dart';

Future<List<FileDataView>> uploadImagesToReceipt(String receiptId) async {
  try {
    // TODO: pass back the file data views, then add them to receipt via receipt provider. We can use an images array stream, then set up a listener in the carousel
    List<FileDataView> filesUploaded = [];
    var multiPartFileUploadData = await scanImagesMultiPart(5) ?? [];
    for (var file in multiPartFileUploadData) {
      var fileDataView = await ReceiptImageApi()
          .uploadReceiptImage(file.multipartFile, int.parse(receiptId));
      filesUploaded.add(fileDataView as FileDataView);
    }
    return filesUploaded;
  } catch (e) {
    print(e);
    return [];
  }
}
