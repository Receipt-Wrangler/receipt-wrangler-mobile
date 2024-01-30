//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DashboardApi {
  DashboardApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create dashboard
  ///
  /// This will create a dashboard [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpsertDashboardCommand] upsertDashboardCommand (required):
  ///   Dashboard
  Future<Response> createDashboardWithHttpInfo(UpsertDashboardCommand upsertDashboardCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/dashboard/';

    // ignore: prefer_final_locals
    Object? postBody = upsertDashboardCommand;

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

  /// Create dashboard
  ///
  /// This will create a dashboard [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [UpsertDashboardCommand] upsertDashboardCommand (required):
  ///   Dashboard
  Future<Dashboard?> createDashboard(UpsertDashboardCommand upsertDashboardCommand,) async {
    final response = await createDashboardWithHttpInfo(upsertDashboardCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Dashboard',) as Dashboard;
    
    }
    return null;
  }

  /// Delete dashboard
  ///
  /// This will delete a dashboard by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] dashboardId (required):
  ///   Id of dashboard to operate on
  Future<Response> deleteDashboardWithHttpInfo(int dashboardId,) async {
    // ignore: prefer_const_declarations
    final path = r'/dashboard/{dashboardId}'
      .replaceAll('{dashboardId}', dashboardId.toString());

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

  /// Delete dashboard
  ///
  /// This will delete a dashboard by id
  ///
  /// Parameters:
  ///
  /// * [int] dashboardId (required):
  ///   Id of dashboard to operate on
  Future<Dashboard?> deleteDashboard(int dashboardId,) async {
    final response = await deleteDashboardWithHttpInfo(dashboardId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Dashboard',) as Dashboard;
    
    }
    return null;
  }

  /// Get dashboards for a user by group id
  ///
  /// This will get a dashboards for a user by group id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///   Id of group to get dashboard for
  Future<Response> getDashboardsForUserByGroupIdWithHttpInfo(String groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/dashboard/{groupId}'
      .replaceAll('{groupId}', groupId);

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

  /// Get dashboards for a user by group id
  ///
  /// This will get a dashboards for a user by group id
  ///
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///   Id of group to get dashboard for
  Future<List<Dashboard>?> getDashboardsForUserByGroupId(String groupId,) async {
    final response = await getDashboardsForUserByGroupIdWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Dashboard>') as List)
        .cast<Dashboard>()
        .toList(growable: false);

    }
    return null;
  }

  /// Update dashboard
  ///
  /// This will update a dashboard
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] dashboardId (required):
  ///   Id of dashboard to operate on
  ///
  /// * [UpsertDashboardCommand] upsertDashboardCommand (required):
  ///   Dashboard to update
  Future<Response> updateDashboardWithHttpInfo(int dashboardId, UpsertDashboardCommand upsertDashboardCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/dashboard/{dashboardId}'
      .replaceAll('{dashboardId}', dashboardId.toString());

    // ignore: prefer_final_locals
    Object? postBody = upsertDashboardCommand;

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

  /// Update dashboard
  ///
  /// This will update a dashboard
  ///
  /// Parameters:
  ///
  /// * [int] dashboardId (required):
  ///   Id of dashboard to operate on
  ///
  /// * [UpsertDashboardCommand] upsertDashboardCommand (required):
  ///   Dashboard to update
  Future<Dashboard?> updateDashboard(int dashboardId, UpsertDashboardCommand upsertDashboardCommand,) async {
    final response = await updateDashboardWithHttpInfo(dashboardId, upsertDashboardCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Dashboard',) as Dashboard;
    
    }
    return null;
  }
}
