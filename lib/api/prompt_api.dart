//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PromptApi {
  PromptApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create default prompt
  ///
  /// This will create a default prompt
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> createDefaultPromptWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/createDefaultPrompt';

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

  /// Create default prompt
  ///
  /// This will create a default prompt
  Future<Prompt?> createDefaultPrompt() async {
    final response = await createDefaultPromptWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Prompt',) as Prompt;
    
    }
    return null;
  }

  /// Create prompt
  ///
  /// This will create a prompt
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertPromptCommand] upsertPromptCommand (required):
  ///   Prompt to create
  Future<Response> createPromptWithHttpInfo(UpsertPromptCommand upsertPromptCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/';

    // ignore: prefer_final_locals
    Object? postBody = upsertPromptCommand;

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

  /// Create prompt
  ///
  /// This will create a prompt
  ///
  /// Parameters:
  ///
  /// * [UpsertPromptCommand] upsertPromptCommand (required):
  ///   Prompt to create
  Future<Prompt?> createPrompt(UpsertPromptCommand upsertPromptCommand,) async {
    final response = await createPromptWithHttpInfo(upsertPromptCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Prompt',) as Prompt;
    
    }
    return null;
  }

  /// Delete prompt by id
  ///
  /// This will delete a prompt by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to delete
  Future<Response> deletePromptByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/{id}'
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

  /// Delete prompt by id
  ///
  /// This will delete a prompt by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to delete
  Future<void> deletePromptById(int id,) async {
    final response = await deletePromptByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Gets paged prompts
  ///
  /// This will return paged prompts
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedPromptsWithHttpInfo(PagedRequestCommand pagedRequestCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/getPagedPrompts';

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

  /// Gets paged prompts
  ///
  /// This will return paged prompts
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedPrompts(PagedRequestCommand pagedRequestCommand,) async {
    final response = await getPagedPromptsWithHttpInfo(pagedRequestCommand,);
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

  /// Get prompt by id
  ///
  /// This will get a prompt by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to get
  Future<Response> getPromptByIdWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/{id}'
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

  /// Get prompt by id
  ///
  /// This will get a prompt by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to get
  Future<Prompt?> getPromptById(int id,) async {
    final response = await getPromptByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Prompt',) as Prompt;
    
    }
    return null;
  }

  /// Update prompt by id
  ///
  /// This will update a prompt by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to update
  ///
  /// * [UpsertPromptCommand] upsertPromptCommand (required):
  ///   Prompt to update
  Future<Response> updatePromptByIdWithHttpInfo(int id, UpsertPromptCommand upsertPromptCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/prompt/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertPromptCommand;

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

  /// Update prompt by id
  ///
  /// This will update a prompt by id
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///   Id of prompt to update
  ///
  /// * [UpsertPromptCommand] upsertPromptCommand (required):
  ///   Prompt to update
  Future<Prompt?> updatePromptById(int id, UpsertPromptCommand upsertPromptCommand,) async {
    final response = await updatePromptByIdWithHttpInfo(id, upsertPromptCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Prompt',) as Prompt;
    
    }
    return null;
  }
}
