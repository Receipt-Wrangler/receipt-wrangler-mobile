//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReceiptApi {
  ReceiptApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Bulk receipt status update
  ///
  /// This will bulk update receipt statuses with the option of adding a comment to each [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BulkStatusUpdateCommand] bulkStatusUpdateCommand (required):
  ///   Bulk status data
  Future<Response> bulkReceiptStatusUpdateWithHttpInfo(
    BulkStatusUpdateCommand bulkStatusUpdateCommand,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/receipt/bulkStatusUpdate';

    // ignore: prefer_final_locals
    Object? postBody = bulkStatusUpdateCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

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

  /// Bulk receipt status update
  ///
  /// This will bulk update receipt statuses with the option of adding a comment to each [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [BulkStatusUpdateCommand] bulkStatusUpdateCommand (required):
  ///   Bulk status data
  Future<List<Receipt>?> bulkReceiptStatusUpdate(
    BulkStatusUpdateCommand bulkStatusUpdateCommand,
  ) async {
    final response = await bulkReceiptStatusUpdateWithHttpInfo(
      bulkStatusUpdateCommand,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Receipt>')
              as List)
          .cast<Receipt>()
          .toList();
    }
    return null;
  }

  /// Create receipt
  ///
  /// This will create a receipt [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertReceiptCommand] upsertReceiptCommand (required):
  ///   Receipt to create
  Future<Response> createReceiptWithHttpInfo(
    UpsertReceiptCommand upsertReceiptCommand,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/receipt/';

    // ignore: prefer_final_locals
    Object? postBody = upsertReceiptCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

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

  /// Create receipt
  ///
  /// This will create a receipt [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [UpsertReceiptCommand] upsertReceiptCommand (required):
  ///   Receipt to create
  Future<void> createReceipt(
    UpsertReceiptCommand upsertReceiptCommand,
  ) async {
    final response = await createReceiptWithHttpInfo(
      upsertReceiptCommand,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete receipt
  ///
  /// This will delete a receipt by id [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  Future<Response> deleteReceiptByIdWithHttpInfo(
    int receiptId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/receipt/{receiptId}'.replaceAll('{receiptId}', receiptId.toString());

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

  /// Delete receipt
  ///
  /// This will delete a receipt by id [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  Future<void> deleteReceiptById(
    int receiptId,
  ) async {
    final response = await deleteReceiptByIdWithHttpInfo(
      receiptId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Duplicate receipt
  ///
  /// This will duplicate a receipt [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to duplicate
  Future<Response> duplicateReceiptWithHttpInfo(
    int receiptId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/receipt/{receiptId}/duplicate'
        .replaceAll('{receiptId}', receiptId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

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

  /// Duplicate receipt
  ///
  /// This will duplicate a receipt [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to duplicate
  Future<void> duplicateReceipt(
    int receiptId,
  ) async {
    final response = await duplicateReceiptWithHttpInfo(
      receiptId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get receipt
  ///
  /// This will get a receipt by receipt id [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  Future<Response> getReceiptByIdWithHttpInfo(
    int receiptId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/receipt/{receiptId}'.replaceAll('{receiptId}', receiptId.toString());

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

  /// Get receipt
  ///
  /// This will get a receipt by receipt id [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  Future<Receipt?> getReceiptById(
    int receiptId,
  ) async {
    final response = await getReceiptByIdWithHttpInfo(
      receiptId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Receipt',
      ) as Receipt;
    }
    return null;
  }

  /// Gets receipts
  ///
  /// This will return receipts with the option to sort and filter [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Get all receipts that belong to groupId
  ///
  /// * [ReceiptPagedRequestCommand] receiptPagedRequestCommand (required):
  Future<Response> getReceiptsForGroupWithHttpInfo(
    int groupId,
    ReceiptPagedRequestCommand receiptPagedRequestCommand,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/receipt/group/{groupId}'.replaceAll('{groupId}', groupId.toString());

    // ignore: prefer_final_locals
    Object? postBody = receiptPagedRequestCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

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

  /// Gets receipts
  ///
  /// This will return receipts with the option to sort and filter [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Get all receipts that belong to groupId
  ///
  /// * [ReceiptPagedRequestCommand] receiptPagedRequestCommand (required):
  Future<PagedData?> getReceiptsForGroup(
    int groupId,
    ReceiptPagedRequestCommand receiptPagedRequestCommand,
  ) async {
    final response = await getReceiptsForGroupWithHttpInfo(
      groupId,
      receiptPagedRequestCommand,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PagedData',
      ) as PagedData;
    }
    return null;
  }

  /// Has access to receipt
  ///
  /// This will return whether or not the currently logged in user has access to the receipt
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///
  /// * [String] groupRole:
  ///   Role required to have access to receipt
  Future<Response> hasAccessToReceiptWithHttpInfo(
    int receiptId, {
    String? groupRole,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/receipt/hasAccess';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'receiptId', receiptId));
    if (groupRole != null) {
      queryParams.addAll(_queryParams('', 'groupRole', groupRole));
    }

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

  /// Has access to receipt
  ///
  /// This will return whether or not the currently logged in user has access to the receipt
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///
  /// * [String] groupRole:
  ///   Role required to have access to receipt
  Future<void> hasAccessToReceipt(
    int receiptId, {
    String? groupRole,
  }) async {
    final response = await hasAccessToReceiptWithHttpInfo(
      receiptId,
      groupRole: groupRole,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Quick scan a receipt
  ///
  /// This take an image and use magic fill to fill and save the receipt [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [List<MultipartFile>] files (required):
  ///
  /// * [List<int>] groupIds (required):
  ///
  /// * [List<int>] paidByUserIds (required):
  ///
  /// * [List<ReceiptStatus>] statuses (required):
  Future<Response> quickScanReceiptWithHttpInfo(
    List<MultipartFile> files,
    List<int> groupIds,
    List<int> paidByUserIds,
    List<ReceiptStatus> statuses,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/receipt/quickScan';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (files != null) {
      hasFields = true;
      for (var file in files) {
        mp.files.add(file);
      }
    }
    if (groupIds != null) {
      hasFields = true;
      mp.fields[r'groupIds'] = parameterToString(groupIds);
    }
    if (paidByUserIds != null) {
      hasFields = true;
      mp.fields[r'paidByUserIds'] = parameterToString(paidByUserIds);
    }
    if (statuses != null) {
      hasFields = true;
      mp.fields[r'statuses'] = parameterToString(statuses);
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

  /// Quick scan a receipt
  ///
  /// This take an image and use magic fill to fill and save the receipt [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [List<MultipartFile>] files (required):
  ///
  /// * [List<int>] groupIds (required):
  ///
  /// * [List<int>] paidByUserIds (required):
  ///
  /// * [List<ReceiptStatus>] statuses (required):
  Future<List<Receipt>?> quickScanReceipt(
    List<MultipartFile> files,
    List<int> groupIds,
    List<int> paidByUserIds,
    List<ReceiptStatus> statuses,
  ) async {
    final response = await quickScanReceiptWithHttpInfo(
      files,
      groupIds,
      paidByUserIds,
      statuses,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Receipt>')
              as List)
          .cast<Receipt>()
          .toList();
    }
    return null;
  }

  /// Update receipt
  ///
  /// This will update a receipt by receipt id [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  ///
  /// * [UpsertReceiptCommand] upsertReceiptCommand (required):
  ///   Receipt to update
  Future<Response> updateReceiptWithHttpInfo(
    int receiptId,
    UpsertReceiptCommand upsertReceiptCommand,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/receipt/{receiptId}'.replaceAll('{receiptId}', receiptId.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertReceiptCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update receipt
  ///
  /// This will update a receipt by receipt id [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] receiptId (required):
  ///   Id of receipt to get
  ///
  /// * [UpsertReceiptCommand] upsertReceiptCommand (required):
  ///   Receipt to update
  Future<void> updateReceipt(
    int receiptId,
    UpsertReceiptCommand upsertReceiptCommand,
  ) async {
    final response = await updateReceiptWithHttpInfo(
      receiptId,
      upsertReceiptCommand,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
