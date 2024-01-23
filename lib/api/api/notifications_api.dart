//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class NotificationsApi {
  NotificationsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete all notifications for user
  ///
  /// This deletes all notifications for a user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteAllNotificationsForUserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/notifications/';

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

  /// Delete all notifications for user
  ///
  /// This deletes all notifications for a user
  Future<void> deleteAllNotificationsForUser() async {
    final response = await deleteAllNotificationsForUserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete notification by id
  ///
  /// This deletes a notification by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] notificationId (required):
  ///   Notification Id to delete
  Future<Response> deleteNotificationByIdWithHttpInfo(int notificationId,) async {
    // ignore: prefer_const_declarations
    final path = r'/notifications/{notificationId}'
      .replaceAll('{notificationId}', notificationId.toString());

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

  /// Delete notification by id
  ///
  /// This deletes a notification by id
  ///
  /// Parameters:
  ///
  /// * [int] notificationId (required):
  ///   Notification Id to delete
  Future<void> deleteNotificationById(int notificationId,) async {
    final response = await deleteNotificationByIdWithHttpInfo(notificationId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Notification count
  ///
  /// This will get the notification count for the currently logged in user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getNotificationCountWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/notifications/notificationCount';

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

  /// Notification count
  ///
  /// This will get the notification count for the currently logged in user
  Future<int?> getNotificationCount() async {
    final response = await getNotificationCountWithHttpInfo();
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

  /// Get all user notifications
  ///
  /// This will get all the notifications for the currently logged in user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getNotificationsForuserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/notifications/';

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

  /// Get all user notifications
  ///
  /// This will get all the notifications for the currently logged in user
  Future<List<Notification>?> getNotificationsForuser() async {
    final response = await getNotificationsForuserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Notification>') as List)
        .cast<Notification>()
        .toList(growable: false);

    }
    return null;
  }
}
