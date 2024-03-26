import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_selector/file_selector.dart';
import 'package:http/http.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';

const fileFieldName = "files";

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
    var multipartFile = await MultipartFile.fromPath(fileFieldName, filePath);
    var bytes = await File(filePath).readAsBytes();

    files.add(
        UploadMultipartFileData(multipartFile: multipartFile, bytes: bytes));
  }

  return files;
}

Future<List<UploadMultipartFileData>> getGalleryImages() async {
  var files = <UploadMultipartFileData>[];
  //TODO: restrict types
  const XTypeGroup typeGroup = XTypeGroup();
  List<XFile> openedFiles = [];

  switch (Platform.operatingSystem) {
    case "android":
      openedFiles = await openAndroidGallery(typeGroup);
      break;
    case "ios":
      openedFiles = await openIOSGallery(typeGroup);
      break;
    default:
      throw Exception("Unsupported platform");
  }

  for (var file in openedFiles) {
    var bytes = await file.readAsBytes();
    var multipartFile = await MultipartFile.fromBytes(fileFieldName, bytes,
        filename: file.name);
    files.add(
        UploadMultipartFileData(multipartFile: multipartFile, bytes: bytes));
  }

  return files;
}

Future<List<XFile>> openIOSGallery(XTypeGroup typeGroup) async {
  return await openFiles(acceptedTypeGroups: <XTypeGroup>[
    typeGroup,
    //pngTypeGroup,
  ]);
}

Future<List<XFile>> openAndroidGallery(XTypeGroup typeGroup) async {
  return await openFiles();
}
