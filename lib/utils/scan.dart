import 'package:cunning_document_scanner/cunning_document_scanner.dart';

Future<List<String>?> scanImages(int numberOfPages) async {
  return await CunningDocumentScanner.getPictures(noOfPages: numberOfPages);
}
