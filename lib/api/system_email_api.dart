//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemEmailApi {
  SystemEmailApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Check system email connectivity
  ///
  /// This will check system email connectivity
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CheckEmailConnectivityCommand] checkEmailConnectivityCommand (required):
  ///   System email to check connectivity
  Future<Response> checkSystemEmailConnectivityWithHttpInfo(CheckEmailConnectivityCommand checkEmailConnectivityCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/checkConnectivity';

    // ignore: prefer_final_locals
    Object? postBody = checkEmailConnectivityCommand;

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

  /// Check system email connectivity
  ///
  /// This will check system email connectivity
  ///
  /// Parameters:
  ///
  /// * [CheckEmailConnectivityCommand] checkEmailConnectivityCommand (required):
  ///   System email to check connectivity
  Future<void> checkSystemEmailConnectivity(CheckEmailConnectivityCommand checkEmailConnectivityCommand,) async {
    final response = await checkSystemEmailConnectivityWithHttpInfo(checkEmailConnectivityCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Create system email
  ///
  /// This will create a system email
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertSystemEmailCommand] upsertSystemEmailCommand (required):
  ///   System email to create
  Future<Response> createSystemEmailWithHttpInfo(UpsertSystemEmailCommand upsertSystemEmailCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/';

    // ignore: prefer_final_locals
    Object? postBody = upsertSystemEmailCommand;

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

  /// Create system email
  ///
  /// This will create a system email
  ///
  /// Parameters:
  ///
  /// * [UpsertSystemEmailCommand] upsertSystemEmailCommand (required):
  ///   System email to create
  Future<SystemEmail?> createSystemEmail(UpsertSystemEmailCommand upsertSystemEmailCommand,) async {
    final response = await createSystemEmailWithHttpInfo(upsertSystemEmailCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemEmail',) as SystemEmail;
    
    }
    return null;
  }

  /// Delete system email by id
  ///
  /// This will delete a system email by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to delete
  Future<Response> deleteSystemEmailByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/{id}'
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

  /// Delete system email by id
  ///
  /// This will delete a system email by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to delete
  Future<void> deleteSystemEmailById(int id,) async {
    final response = await deleteSystemEmailByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Gets paged system emails
  ///
  /// This will return paged and sorted system emails
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedSystemEmailsWithHttpInfo(PagedRequestCommand pagedRequestCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/getSystemEmails';

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

  /// Gets paged system emails
  ///
  /// This will return paged and sorted system emails
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedSystemEmails(PagedRequestCommand pagedRequestCommand,) async {
    final response = await getPagedSystemEmailsWithHttpInfo(pagedRequestCommand,);
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

  /// Get system email by id
  ///
  /// This will get a system email by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to get
  Future<Response> getSystemEmailByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/{id}'
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

  /// Get system email by id
  ///
  /// This will get a system email by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to get
  Future<SystemEmail?> getSystemEmailById(int id,) async {
    final response = await getSystemEmailByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemEmail',) as SystemEmail;
    
    }
    return null;
  }

  /// Update system email by id
  ///
  /// This will update a system email by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to update
  ///
  /// * [bool] updatePassword (required):
  ///   Whether or not to update the password
  ///
  /// * [UpsertSystemEmailCommand] upsertSystemEmailCommand (required):
  ///   System email to update
  Future<Response> updateSystemEmailByIdWithHttpInfo(int id, bool updatePassword, UpsertSystemEmailCommand upsertSystemEmailCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemEmail/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertSystemEmailCommand;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'updatePassword', updatePassword));

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

  /// Update system email by id
  ///
  /// This will update a system email by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of system email to update
  ///
  /// * [bool] updatePassword (required):
  ///   Whether or not to update the password
  ///
  /// * [UpsertSystemEmailCommand] upsertSystemEmailCommand (required):
  ///   System email to update
  Future<SystemEmail?> updateSystemEmailById(int id, bool updatePassword, UpsertSystemEmailCommand upsertSystemEmailCommand,) async {
    final response = await updateSystemEmailByIdWithHttpInfo(id, updatePassword, upsertSystemEmailCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemEmail',) as SystemEmail;
    
    }
    return null;
  }
}
