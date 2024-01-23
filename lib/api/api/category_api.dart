//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CategoryApi {
  CategoryApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create category
  ///
  /// This will create a category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Category] category (required):
  ///   Category to create
  Future<Response> createCategoryWithHttpInfo(
    Category category,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/category/';

    // ignore: prefer_final_locals
    Object? postBody = category;

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

  /// Create category
  ///
  /// This will create a category
  ///
  /// Parameters:
  ///
  /// * [Category] category (required):
  ///   Category to create
  Future<void> createCategory(
    Category category,
  ) async {
    final response = await createCategoryWithHttpInfo(
      category,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete category
  ///
  /// This will delete a category by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///   Category Id to get
  Future<Response> deleteCategoryWithHttpInfo(
    int categoryId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{categoryId}'
        .replaceAll('{categoryId}', categoryId.toString());

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

  /// Delete category
  ///
  /// This will delete a category by id
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///   Category Id to get
  Future<void> deleteCategory(
    int categoryId,
  ) async {
    final response = await deleteCategoryWithHttpInfo(
      categoryId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get all categories
  ///
  /// This will return all categories in the system
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllCategoriesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/category/';

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

  /// Get all categories
  ///
  /// This will return all categories in the system
  Future<List<Category>?> getAllCategories() async {
    final response = await getAllCategoriesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Category>')
              as List)
          .cast<Category>()
          .toList(growable: false);
    }
    return null;
  }

  /// Get category count by name
  ///
  /// This will return a count of categories with the same name
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] categoryName (required):
  ///   Category name to get count of
  Future<Response> getCategoryCountByNameWithHttpInfo(
    String categoryName,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/category/{categoryName}'.replaceAll('{categoryName}', categoryName);

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

  /// Get category count by name
  ///
  /// This will return a count of categories with the same name
  ///
  /// Parameters:
  ///
  /// * [String] categoryName (required):
  ///   Category name to get count of
  Future<int?> getCategoryCountByName(
    String categoryName,
  ) async {
    final response = await getCategoryCountByNameWithHttpInfo(
      categoryName,
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
        'int',
      ) as int;
    }
    return null;
  }

  /// Get paged categories
  ///
  /// This will return paged categories
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedRequestCommand] pagedRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedCategoriesWithHttpInfo(
    PagedRequestCommand pagedRequestCommand,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/category/getPagedCategories';

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

  /// Update category
  ///
  /// This will update a category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///   Category Id to get
  ///
  /// * [Category] category (required):
  ///   Category to update
  Future<Response> updateCategoryWithHttpInfo(
    int categoryId,
    Category category,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{categoryId}'
        .replaceAll('{categoryId}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody = category;

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

  /// Update category
  ///
  /// This will update a category
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///   Category Id to get
  ///
  /// * [Category] category (required):
  ///   Category to update
  Future<void> updateCategory(
    int categoryId,
    Category category,
  ) async {
    final response = await updateCategoryWithHttpInfo(
      categoryId,
      category,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
