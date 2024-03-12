import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:http/http.dart';

Future<List<String>> scanImages(int numberOfPages) async {
  return await CunningDocumentScanner.getPictures(noOfPages: numberOfPages) ??
      [];
}

Future<List<MultipartFile>> scanImagesMultiPart(int numberOfPages) async {
  var files = <MultipartFile>[];
  var filePaths =
      await CunningDocumentScanner.getPictures(noOfPages: numberOfPages);

  if (filePaths!.isEmpty) {
    return files;
  }

  for (var filePath in filePaths) {
    var multipartFile = await MultipartFile.fromPath("file", filePath);
    files.add(multipartFile);
  }

  return files;
}
