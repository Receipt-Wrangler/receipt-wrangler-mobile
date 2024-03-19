//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get fresh tokens
  ///
  /// This will get a fresh token pair for the user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LogoutCommand] logoutCommand:
  ///   Refresh token body for clients that don't use cookies
  Future<Response> getNewRefreshTokenWithHttpInfo({ LogoutCommand? logoutCommand, }) async {
    // ignore: prefer_const_declarations
    final path = r'/token/';

    // ignore: prefer_final_locals
    Object? postBody = logoutCommand;

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

  /// Get fresh tokens
  ///
  /// This will get a fresh token pair for the user
  ///
  /// Parameters:
  ///
  /// * [LogoutCommand] logoutCommand:
  ///   Refresh token body for clients that don't use cookies
  Future<GetNewRefreshToken200Response?> getNewRefreshToken({ LogoutCommand? logoutCommand, }) async {
    final response = await getNewRefreshTokenWithHttpInfo( logoutCommand: logoutCommand, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetNewRefreshToken200Response',) as GetNewRefreshToken200Response;
    
    }
    return null;
  }

  /// Login
  ///
  /// This will log a user into the system
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LoginCommand] loginCommand (required):
  ///   Login data
  Future<Response> loginWithHttpInfo(LoginCommand loginCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/login/';

    // ignore: prefer_final_locals
    Object? postBody = loginCommand;

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

  /// Login
  ///
  /// This will log a user into the system
  ///
  /// Parameters:
  ///
  /// * [LoginCommand] loginCommand (required):
  ///   Login data
  Future<AppData?> login(LoginCommand loginCommand,) async {
    final response = await loginWithHttpInfo(loginCommand,);
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

  /// Logout
  ///
  /// This will log a user out of the system and revoke their token [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LogoutCommand] logoutCommand:
  ///   Refresh token
  Future<Response> logoutWithHttpInfo({ LogoutCommand? logoutCommand, }) async {
    // ignore: prefer_const_declarations
    final path = r'/logout/';

    // ignore: prefer_final_locals
    Object? postBody = logoutCommand;

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

  /// Logout
  ///
  /// This will log a user out of the system and revoke their token [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [LogoutCommand] logoutCommand:
  ///   Refresh token
  Future<void> logout({ LogoutCommand? logoutCommand, }) async {
    final response = await logoutWithHttpInfo( logoutCommand: logoutCommand, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Signs up
  ///
  /// This will sign a user up for the system
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SignUpCommand] signUpCommand (required):
  ///   Sign up data
  Future<Response> signUpWithHttpInfo(SignUpCommand signUpCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/signUp';

    // ignore: prefer_final_locals
    Object? postBody = signUpCommand;

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

  /// Signs up
  ///
  /// This will sign a user up for the system
  ///
  /// Parameters:
  ///
  /// * [SignUpCommand] signUpCommand (required):
  ///   Sign up data
  Future<void> signUp(SignUpCommand signUpCommand,) async {
    final response = await signUpWithHttpInfo(signUpCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
