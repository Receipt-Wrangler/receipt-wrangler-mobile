//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReceiptImageApi {
  ReceiptImageApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Converts a receipt image to jpg
  ///
  /// This will convert a receipt image to jpg, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///   Base64 encoded image
  Future<Response> convertToJpgWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/convertToJpg';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Converts a receipt image to jpg
  ///
  /// This will convert a receipt image to jpg, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///   Base64 encoded image
  Future<EncodedImage?> convertToJpg(MultipartFile file,) async {
    final response = await convertToJpgWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'EncodedImage',) as EncodedImage;
    
    }
    return null;
  }

  /// Delete receipt image
  ///
  /// This will delete a receipt image by id [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to get
  Future<Response> deleteReceiptImageByIdWithHttpInfo(int receiptImageId,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/{receiptImageId}'
      .replaceAll('{receiptImageId}', receiptImageId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete receipt image
  ///
  /// This will delete a receipt image by id [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to get
  Future<void> deleteReceiptImageById(int receiptImageId,) async {
    final response = await deleteReceiptImageByIdWithHttpInfo(receiptImageId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Download receipt image
  ///
  /// This will download a receipt image by id, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to download
  Future<Response> downloadReceiptImageByIdWithHttpInfo(int receiptImageId,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/{receiptImageId}/download'
      .replaceAll('{receiptImageId}', receiptImageId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Download receipt image
  ///
  /// This will download a receipt image by id, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to download
  Future<MultipartFile?> downloadReceiptImageById(int receiptImageId,) async {
    final response = await downloadReceiptImageByIdWithHttpInfo(receiptImageId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MultipartFile',) as MultipartFile;
    
    }
    return null;
  }

  /// Get receipt image
  ///
  /// This will get a receipt image by id, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to get
  Future<Response> getReceiptImageByIdWithHttpInfo(int receiptImageId,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/{receiptImageId}'
      .replaceAll('{receiptImageId}', receiptImageId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get receipt image
  ///
  /// This will get a receipt image by id, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId (required):
  ///   Id of receipt image to get
  Future<FileDataView?> getReceiptImageById(int receiptImageId,) async {
    final response = await getReceiptImageByIdWithHttpInfo(receiptImageId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FileDataView',) as FileDataView;
    
    }
    return null;
  }

  /// Reads a receipt image and returns the parsed results
  ///
  /// This will parse and read a receipt image, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId:
  ///   Id of receipt image to perform magic fill on
  ///
  /// * [MultipartFile] file:
  Future<Response> magicFillReceiptWithHttpInfo({ int? receiptImageId, MultipartFile? file, }) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/magicFill';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (receiptImageId != null) {
      queryParams.addAll(_queryParams('', 'receiptImageId', receiptImageId));
    }

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Reads a receipt image and returns the parsed results
  ///
  /// This will parse and read a receipt image, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptImageId:
  ///   Id of receipt image to perform magic fill on
  ///
  /// * [MultipartFile] file:
  Future<Receipt?> magicFillReceipt({ int? receiptImageId, MultipartFile? file, }) async {
    final response = await magicFillReceiptWithHttpInfo( receiptImageId: receiptImageId, file: file, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Receipt',) as Receipt;
    
    }
    return null;
  }

  /// Uploads a receipt image
  ///
  /// This will upload a receipt image, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///
  /// * [int] receiptId (required):
  ///   Receipt foreign key
  ///
  /// * [String] encodedImage:
  ///   Base64 encoded image for file types that aren't viewable natively in the browser, such as PDFs
  Future<Response> uploadReceiptImageWithHttpInfo(MultipartFile file, int receiptId, { String? encodedImage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptImage/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (receiptId != null) {
      hasFields = true;
      mp.fields[r'receiptId'] = parameterToString(receiptId);
    }
    if (encodedImage != null) {
      hasFields = true;
      mp.fields[r'encodedImage'] = parameterToString(encodedImage);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Uploads a receipt image
  ///
  /// This will upload a receipt image, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///
  /// * [int] receiptId (required):
  ///   Receipt foreign key
  ///
  /// * [String] encodedImage:
  ///   Base64 encoded image for file types that aren't viewable natively in the browser, such as PDFs
  Future<FileDataView?> uploadReceiptImage(MultipartFile file, int receiptId, { String? encodedImage, }) async {
    final response = await uploadReceiptImageWithHttpInfo(file, receiptId,  encodedImage: encodedImage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FileDataView',) as FileDataView;
    
    }
    return null;
  }
}
