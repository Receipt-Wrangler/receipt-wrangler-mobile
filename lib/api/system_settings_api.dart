//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemSettingsApi {
  SystemSettingsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get system settings
  ///
  /// This will get system settings
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSystemSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/systemSettings';

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

  /// Get system settings
  ///
  /// This will get system settings
  Future<SystemSettings?> getSystemSettings() async {
    final response = await getSystemSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemSettings',) as SystemSettings;
    
    }
    return null;
  }

  /// Update system settings
  ///
  /// This will update system settings
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertSystemSettingsCommand] upsertSystemSettingsCommand (required):
  ///   System settings to update
  Future<Response> updateSystemSettingsWithHttpInfo(UpsertSystemSettingsCommand upsertSystemSettingsCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/systemSettings';

    // ignore: prefer_final_locals
    Object? postBody = upsertSystemSettingsCommand;

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

  /// Update system settings
  ///
  /// This will update system settings
  ///
  /// Parameters:
  ///
  /// * [UpsertSystemSettingsCommand] upsertSystemSettingsCommand (required):
  ///   System settings to update
  Future<SystemSettings?> updateSystemSettings(UpsertSystemSettingsCommand upsertSystemSettingsCommand,) async {
    final response = await updateSystemSettingsWithHttpInfo(upsertSystemSettingsCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemSettings',) as SystemSettings;
    
    }
    return null;
  }
}
