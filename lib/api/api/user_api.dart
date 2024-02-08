//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserApi {
  UserApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Converts dummy user
  ///
  /// This will convert a dummy user to a normal system user, [SYSTEM ADMIN]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to convert to normal system user
  ///
  /// * [ResetPasswordCommand] resetPasswordCommand (required):
  ///   Login credentials for new user
  Future<Response> convertDummyUserByIdWithHttpInfo(int userId, ResetPasswordCommand resetPasswordCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/{userId}/convertDummyUserToNormalUser'
      .replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = resetPasswordCommand;

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

  /// Converts dummy user
  ///
  /// This will convert a dummy user to a normal system user, [SYSTEM ADMIN]
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to convert to normal system user
  ///
  /// * [ResetPasswordCommand] resetPasswordCommand (required):
  ///   Login credentials for new user
  Future<void> convertDummyUserById(int userId, ResetPasswordCommand resetPasswordCommand,) async {
    final response = await convertDummyUserByIdWithHttpInfo(userId, resetPasswordCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Create user
  ///
  /// This will to create a user, [SYSTEM ADMIN]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [User] user (required):
  ///   User to create
  Future<Response> createUserWithHttpInfo(User user,) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody = user;

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

  /// Create user
  ///
  /// This will to create a user, [SYSTEM ADMIN]
  ///
  /// Parameters:
  ///
  /// * [User] user (required):
  ///   User to create
  Future<void> createUser(User user,) async {
    final response = await createUserWithHttpInfo(user,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete user
  ///
  /// This will delete a system user by id [SYSTEM ADMIN]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to update
  Future<Response> deleteUserByIdWithHttpInfo(int userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/{userId}'
      .replaceAll('{userId}', userId.toString());

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

  /// Delete user
  ///
  /// This will delete a system user by id [SYSTEM ADMIN]
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to update
  Future<void> deleteUserById(int userId,) async {
    final response = await deleteUserByIdWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get amount owed for user
  ///
  /// This will return the amount owed for the logged in user, in the specified group, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId:
  ///   The Id of the group to get amount owed for
  ///
  /// * [List<int>] receiptIds:
  ///   The Id of the receipts to get amount owed for
  Future<Response> getAmountOwedForUserWithHttpInfo({ int? groupId, List<int>? receiptIds, }) async {
    // ignore: prefer_const_declarations
    final path = r'/user/amountOwedForUser';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }
    if (receiptIds != null) {
      queryParams.addAll(_queryParams('multi', 'receiptIds', receiptIds));
    }

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

  /// Get amount owed for user
  ///
  /// This will return the amount owed for the logged in user, in the specified group, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [int] groupId:
  ///   The Id of the group to get amount owed for
  ///
  /// * [List<int>] receiptIds:
  ///   The Id of the receipts to get amount owed for
  Future<Map<String, String>?> getAmountOwedForUser({ int? groupId, List<int>? receiptIds, }) async {
    final response = await getAmountOwedForUserWithHttpInfo( groupId: groupId, receiptIds: receiptIds, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return Map<String, String>.from(await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Map<String, String>'),);

    }
    return null;
  }

  /// Get app data
  ///
  /// This will return the user's app data for the currently logged in user [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAppDataWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/user/appData';

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

  /// Get app data
  ///
  /// This will return the user's app data for the currently logged in user [SYSTEM USER]
  Future<AppData?> getAppData() async {
    final response = await getAppDataWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AppData',) as AppData;
    
    }
    return null;
  }

  /// Get claims for logged in user
  ///
  /// This will return the user's token claims for the currently logged in user [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUserClaimsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/user/getUserClaims';

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

  /// Get claims for logged in user
  ///
  /// This will return the user's token claims for the currently logged in user [SYSTEM USER]
  Future<Claims?> getUserClaims() async {
    final response = await getUserClaimsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claims',) as Claims;
    
    }
    return null;
  }

  /// Get username count
  ///
  /// This will return the number of users in the system with the same username
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] username (required):
  ///   Username to get the count of
  Future<Response> getUsernameCountWithHttpInfo(String username,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/{username}'
      .replaceAll('{username}', username);

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

  /// Get username count
  ///
  /// This will return the number of users in the system with the same username
  ///
  /// Parameters:
  ///
  /// * [String] username (required):
  ///   Username to get the count of
  Future<int?> getUsernameCount(String username,) async {
    final response = await getUsernameCountWithHttpInfo(username,);
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

  /// Get users
  ///
  /// This will get all the users in the system and return a view without sensative information
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUsersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/user';

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

  /// Get users
  ///
  /// This will get all the users in the system and return a view without sensative information
  Future<List<UserView>?> getUsers() async {
    final response = await getUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<UserView>') as List)
        .cast<UserView>()
        .toList(growable: false);

    }
    return null;
  }

  /// Reset password
  ///
  /// This will reset a password for a user, [SYSTEM ADMIN]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to reset password
  ///
  /// * [ResetPasswordCommand] resetPasswordCommand (required):
  ///   Login credentials for new user
  Future<Response> resetPasswordByIdWithHttpInfo(int userId, ResetPasswordCommand resetPasswordCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/{userId}/resetPassword'
      .replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = resetPasswordCommand;

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

  /// Reset password
  ///
  /// This will reset a password for a user, [SYSTEM ADMIN]
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to reset password
  ///
  /// * [ResetPasswordCommand] resetPasswordCommand (required):
  ///   Login credentials for new user
  Future<void> resetPasswordById(int userId, ResetPasswordCommand resetPasswordCommand,) async {
    final response = await resetPasswordByIdWithHttpInfo(userId, resetPasswordCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update user by id
  ///
  /// This will update a user by id, [SYSTEM ADMIN]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to update
  ///
  /// * [User] user (required):
  ///   User to update
  Future<Response> updateUserByIdWithHttpInfo(int userId, User user,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/{userId}'
      .replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = user;

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

  /// Update user by id
  ///
  /// This will update a user by id, [SYSTEM ADMIN]
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   Id of user to update
  ///
  /// * [User] user (required):
  ///   User to update
  Future<void> updateUserById(int userId, User user,) async {
    final response = await updateUserByIdWithHttpInfo(userId, user,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update user profile
  ///
  /// This will update the logged in user's user profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileCommand] updateProfileCommand (required):
  ///   User profile to update
  Future<Response> updateUserProfileWithHttpInfo(UpdateProfileCommand updateProfileCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/updateUserProfile';

    // ignore: prefer_final_locals
    Object? postBody = updateProfileCommand;

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

  /// Update user profile
  ///
  /// This will update the logged in user's user profile
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileCommand] updateProfileCommand (required):
  ///   User profile to update
  Future<void> updateUserProfile(UpdateProfileCommand updateProfileCommand,) async {
    final response = await updateUserProfileWithHttpInfo(updateProfileCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
