//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserPreferencesApi {
  UserPreferencesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get user preferences
  ///
  /// This will return the user's preferences for the currently logged in user [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUserPreferencesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/userPreferences';

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

  /// Get user preferences
  ///
  /// This will return the user's preferences for the currently logged in user [SYSTEM USER]
  Future<UserPreferences?> getUserPreferences() async {
    final response = await getUserPreferencesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserPreferences',) as UserPreferences;
    
    }
    return null;
  }

  /// Update user preferences
  ///
  /// This will update the user's preferences for the currently logged in user [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserPreferences] userPreferences (required):
  ///   User preferences to update
  Future<Response> updateUserPreferencesWithHttpInfo(UserPreferences userPreferences,) async {
    // ignore: prefer_const_declarations
    final path = r'/userPreferences';

    // ignore: prefer_final_locals
    Object? postBody = userPreferences;

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

  /// Update user preferences
  ///
  /// This will update the user's preferences for the currently logged in user [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [UserPreferences] userPreferences (required):
  ///   User preferences to update
  Future<UserPreferences?> updateUserPreferences(UserPreferences userPreferences,) async {
    final response = await updateUserPreferencesWithHttpInfo(userPreferences,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserPreferences',) as UserPreferences;
    
    }
    return null;
  }
}
