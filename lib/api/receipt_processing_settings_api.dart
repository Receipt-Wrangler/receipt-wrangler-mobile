//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReceiptProcessingSettingsApi {
  ReceiptProcessingSettingsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Check receipt processing settings connectivity
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CheckReceiptProcessingSettingsConnectivityCommand] checkReceiptProcessingSettingsConnectivityCommand (required):
  ///   Receipt processing settings to check connectivity
  Future<Response> checkReceiptProcessingSettingsConnectivityWithHttpInfo(CheckReceiptProcessingSettingsConnectivityCommand checkReceiptProcessingSettingsConnectivityCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings/checkConnectivity';

    // ignore: prefer_final_locals
    Object? postBody = checkReceiptProcessingSettingsConnectivityCommand;

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

  /// Check receipt processing settings connectivity
  ///
  /// Parameters:
  ///
  /// * [CheckReceiptProcessingSettingsConnectivityCommand] checkReceiptProcessingSettingsConnectivityCommand (required):
  ///   Receipt processing settings to check connectivity
  Future<SystemTask?> checkReceiptProcessingSettingsConnectivity(CheckReceiptProcessingSettingsConnectivityCommand checkReceiptProcessingSettingsConnectivityCommand,) async {
    final response = await checkReceiptProcessingSettingsConnectivityWithHttpInfo(checkReceiptProcessingSettingsConnectivityCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemTask',) as SystemTask;
    
    }
    return null;
  }

  /// Create receipt processing settings
  ///
  /// This will create receipt processing settings
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertReceiptProcessingSettingsCommand] upsertReceiptProcessingSettingsCommand (required):
  ///   Receipt processing settings to create
  Future<Response> createReceiptProcessingSettingsWithHttpInfo(UpsertReceiptProcessingSettingsCommand upsertReceiptProcessingSettingsCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings';

    // ignore: prefer_final_locals
    Object? postBody = upsertReceiptProcessingSettingsCommand;

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

  /// Create receipt processing settings
  ///
  /// This will create receipt processing settings
  ///
  /// Parameters:
  ///
  /// * [UpsertReceiptProcessingSettingsCommand] upsertReceiptProcessingSettingsCommand (required):
  ///   Receipt processing settings to create
  Future<ReceiptProcessingSettings?> createReceiptProcessingSettings(UpsertReceiptProcessingSettingsCommand upsertReceiptProcessingSettingsCommand,) async {
    final response = await createReceiptProcessingSettingsWithHttpInfo(upsertReceiptProcessingSettingsCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceiptProcessingSettings',) as ReceiptProcessingSettings;
    
    }
    return null;
  }

  /// Delete receipt processing settings by id
  ///
  /// This will delete receipt processing settings by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to delete
  Future<Response> deleteReceiptProcessingSettingsByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings/{id}'
      .replaceAll('{id}', id.toString());

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

  /// Delete receipt processing settings by id
  ///
  /// This will delete receipt processing settings by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to delete
  Future<void> deleteReceiptProcessingSettingsById(int id,) async {
    final response = await deleteReceiptProcessingSettingsByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Gets paged processing settings
  ///
  /// This will return paged processing settings
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedProcessingSettingsWithHttpInfo(PagedRequestCommand pagedRequestCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings/getPagedProcessingSettings';

    // ignore: prefer_final_locals
    Object? postBody = pagedRequestCommand;

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

  /// Gets paged processing settings
  ///
  /// This will return paged processing settings
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedProcessingSettings(PagedRequestCommand pagedRequestCommand,) async {
    final response = await getPagedProcessingSettingsWithHttpInfo(pagedRequestCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PagedData',) as PagedData;
    
    }
    return null;
  }

  /// Get receipt processing settings by id
  ///
  /// This will get receipt processing settings by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to get
  Future<Response> getReceiptProcessingSettingsByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings/{id}'
      .replaceAll('{id}', id.toString());

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

  /// Get receipt processing settings by id
  ///
  /// This will get receipt processing settings by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to get
  Future<ReceiptProcessingSettings?> getReceiptProcessingSettingsById(int id,) async {
    final response = await getReceiptProcessingSettingsByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceiptProcessingSettings',) as ReceiptProcessingSettings;
    
    }
    return null;
  }

  /// Update receipt processing settings by id
  ///
  /// This will update receipt processing settings by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to update
  ///
  /// * [bool] updateKey (required):
  ///   Whether or not to update the key
  ///
  /// * [UpsertReceiptProcessingSettingsCommand] upsertReceiptProcessingSettingsCommand (required):
  ///   Receipt processing settings to update
  Future<Response> updateReceiptProcessingSettingsByIdWithHttpInfo(int id, bool updateKey, UpsertReceiptProcessingSettingsCommand upsertReceiptProcessingSettingsCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/receiptProcessingSettings/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertReceiptProcessingSettingsCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'updateKey', updateKey));

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

  /// Update receipt processing settings by id
  ///
  /// This will update receipt processing settings by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of receipt processing settings to update
  ///
  /// * [bool] updateKey (required):
  ///   Whether or not to update the key
  ///
  /// * [UpsertReceiptProcessingSettingsCommand] upsertReceiptProcessingSettingsCommand (required):
  ///   Receipt processing settings to update
  Future<ReceiptProcessingSettings?> updateReceiptProcessingSettingsById(int id, bool updateKey, UpsertReceiptProcessingSettingsCommand upsertReceiptProcessingSettingsCommand,) async {
    final response = await updateReceiptProcessingSettingsByIdWithHttpInfo(id, updateKey, upsertReceiptProcessingSettingsCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceiptProcessingSettings',) as ReceiptProcessingSettings;
    
    }
    return null;
  }
}
