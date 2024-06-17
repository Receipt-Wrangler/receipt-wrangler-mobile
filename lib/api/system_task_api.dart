//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemTaskApi {
  SystemTaskApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Gets paged system tasks
  ///
  /// This will return paged system tasks
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetSystemTaskCommand] getSystemTaskCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedSystemTasksWithHttpInfo(GetSystemTaskCommand getSystemTaskCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemTask/getPagedSystemTasks';

    // ignore: prefer_final_locals
    Object? postBody = getSystemTaskCommand;

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

  /// Gets paged system tasks
  ///
  /// This will return paged system tasks
  ///
  /// Parameters:
  ///
  /// * [GetSystemTaskCommand] getSystemTaskCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedSystemTasks(GetSystemTaskCommand getSystemTaskCommand,) async {
    final response = await getPagedSystemTasksWithHttpInfo(getSystemTaskCommand,);
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
}
