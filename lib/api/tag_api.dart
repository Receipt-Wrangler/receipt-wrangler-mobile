//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TagApi {
  TagApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create tag
  ///
  /// This will create a tag
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertTagCommand] upsertTagCommand (required):
  ///   Tag to create
  Future<Response> createTagWithHttpInfo(UpsertTagCommand upsertTagCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/tag/';

    // ignore: prefer_final_locals
    Object? postBody = upsertTagCommand;

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

  /// Create tag
  ///
  /// This will create a tag
  ///
  /// Parameters:
  ///
  /// * [UpsertTagCommand] upsertTagCommand (required):
  ///   Tag to create
  Future<Tag?> createTag(UpsertTagCommand upsertTagCommand,) async {
    final response = await createTagWithHttpInfo(upsertTagCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tag',) as Tag;
    
    }
    return null;
  }

  /// Delete tag
  ///
  /// This will delete a tag by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] tagId (required):
  ///   Id of tag to get
  Future<Response> deleteTagWithHttpInfo(int tagId,) async {
    // ignore: prefer_const_declarations
    final path = r'/tag/{tagId}'
      .replaceAll('{tagId}', tagId.toString());

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

  /// Delete tag
  ///
  /// This will delete a tag by id
  ///
  /// Parameters:
  ///
  /// * [int] tagId (required):
  ///   Id of tag to get
  Future<void> deleteTag(int tagId,) async {
    final response = await deleteTagWithHttpInfo(tagId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get all tags
  ///
  /// This will return all tags in the system
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllTagsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/tag/';

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

  /// Get all tags
  ///
  /// This will return all tags in the system
  Future<List<Tag>?> getAllTags() async {
    final response = await getAllTagsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Tag>') as List)
        .cast<Tag>()
        .toList();

    }
    return null;
  }

  /// Get paged tags
  ///
  /// This will return paged tags
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedTagsWithHttpInfo(PagedRequestCommand pagedRequestCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/tag/getPagedTags';

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

  /// Get paged tags
  ///
  /// This will return paged tags
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedTags(PagedRequestCommand pagedRequestCommand,) async {
    final response = await getPagedTagsWithHttpInfo(pagedRequestCommand,);
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

  /// Get tag count by name
  ///
  /// This will count of names with the same name
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] tagName (required):
  ///   Tag name to get count of
  Future<Response> getTagCountByNameWithHttpInfo(String tagName,) async {
    // ignore: prefer_const_declarations
    final path = r'/tag/{tagName}'
      .replaceAll('{tagName}', tagName);

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

  /// Get tag count by name
  ///
  /// This will count of names with the same name
  ///
  /// Parameters:
  ///
  /// * [String] tagName (required):
  ///   Tag name to get count of
  Future<int?> getTagCountByName(String tagName,) async {
    final response = await getTagCountByNameWithHttpInfo(tagName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'int',) as int;
    
    }
    return null;
  }

  /// Update tag
  ///
  /// This will update a tag
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] tagId (required):
  ///   Id of tag to get
  ///
  /// * [UpsertTagCommand] upsertTagCommand (required):
  ///   Tag to update
  Future<Response> updateTagWithHttpInfo(int tagId, UpsertTagCommand upsertTagCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/tag/{tagId}'
      .replaceAll('{tagId}', tagId.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertTagCommand;

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

  /// Update tag
  ///
  /// This will update a tag
  ///
  /// Parameters:
  ///
  /// * [int] tagId (required):
  ///   Id of tag to get
  ///
  /// * [UpsertTagCommand] upsertTagCommand (required):
  ///   Tag to update
  Future<Tag?> updateTag(int tagId, UpsertTagCommand upsertTagCommand,) async {
    final response = await updateTagWithHttpInfo(tagId, upsertTagCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tag',) as Tag;
    
    }
    return null;
  }
}
