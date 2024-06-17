//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class GroupsApi {
  GroupsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create group
  ///
  /// This will create a group
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Group] group (required):
  ///   Group to create
  Future<Response> createGroupWithHttpInfo(Group group,) async {
    // ignore: prefer_const_declarations
    final path = r'/group';

    // ignore: prefer_final_locals
    Object? postBody = group;

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

  /// Create group
  ///
  /// This will create a group
  ///
  /// Parameters:
  ///
  /// * [Group] group (required):
  ///   Group to create
  Future<void> createGroup(Group group,) async {
    final response = await createGroupWithHttpInfo(group,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete group
  ///
  /// This will delete a group by id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  Future<Response> deleteGroupWithHttpInfo(int groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}'
      .replaceAll('{groupId}', groupId.toString());

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

  /// Delete group
  ///
  /// This will delete a group by id
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  Future<void> deleteGroup(int groupId,) async {
    final response = await deleteGroupWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Gets a group by Id
  ///
  /// This will get a group by Id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  Future<Response> getGroupByIdWithHttpInfo(int groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}'
      .replaceAll('{groupId}', groupId.toString());

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

  /// Gets a group by Id
  ///
  /// This will get a group by Id
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  Future<void> getGroupById(int groupId,) async {
    final response = await getGroupByIdWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get groups for user
  ///
  /// This will get groups for the currently logged in user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getGroupsForuserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/group';

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

  /// Get groups for user
  ///
  /// This will get groups for the currently logged in user
  Future<List<Group>?> getGroupsForuser() async {
    final response = await getGroupsForuserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Group>') as List)
        .cast<Group>()
        .toList();

    }
    return null;
  }

  /// Reads each image in a group and returns the zipped read text
  ///
  /// This will get the ocr text, zipped, for each image in a group and one text file per image
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get ocr text for
  Future<Response> getOcrTextForGroupWithHttpInfo(int groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}/ocrText'
      .replaceAll('{groupId}', groupId.toString());

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

  /// Reads each image in a group and returns the zipped read text
  ///
  /// This will get the ocr text, zipped, for each image in a group and one text file per image
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get ocr text for
  Future<void> getOcrTextForGroup(int groupId,) async {
    final response = await getOcrTextForGroupWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get paged groups
  ///
  /// This will return paged groups
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PagedGroupRequestCommand] pagedGroupRequestCommand (required):
  ///   Paging and sorting data
  Future<Response> getPagedGroupsWithHttpInfo(PagedGroupRequestCommand pagedGroupRequestCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/getPagedGroups';

    // ignore: prefer_final_locals
    Object? postBody = pagedGroupRequestCommand;

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

  /// Get paged groups
  ///
  /// This will return paged groups
  ///
  /// Parameters:
  ///
  /// * [PagedGroupRequestCommand] pagedGroupRequestCommand (required):
  ///   Paging and sorting data
  Future<PagedData?> getPagedGroups(PagedGroupRequestCommand pagedGroupRequestCommand,) async {
    final response = await getPagedGroupsWithHttpInfo(pagedGroupRequestCommand,);
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

  /// Poll group email
  ///
  /// This will poll the group email for new receipts and add them to the group
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to poll
  Future<Response> pollGroupEmailWithHttpInfo(int groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}/pollGroupEmail'
      .replaceAll('{groupId}', groupId.toString());

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

  /// Poll group email
  ///
  /// This will poll the group email for new receipts and add them to the group
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to poll
  Future<void> pollGroupEmail(int groupId,) async {
    final response = await pollGroupEmailWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update a group
  ///
  /// This will update a group
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  ///
  /// * [Group] group (required):
  ///   Group to update
  Future<Response> updateGroupWithHttpInfo(int groupId, Group group,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}'
      .replaceAll('{groupId}', groupId.toString());

    // ignore: prefer_final_locals
    Object? postBody = group;

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

  /// Update a group
  ///
  /// This will update a group
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to get
  ///
  /// * [Group] group (required):
  ///   Group to update
  Future<void> updateGroup(int groupId, Group group,) async {
    final response = await updateGroupWithHttpInfo(groupId, group,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update group settings
  ///
  /// This will update the group settings for a group
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to update
  ///
  /// * [UpdateGroupSettingsCommand] updateGroupSettingsCommand (required):
  ///   Group settings to update
  Future<Response> updateGroupSettingsWithHttpInfo(int groupId, UpdateGroupSettingsCommand updateGroupSettingsCommand,) async {
    // ignore: prefer_const_declarations
    final path = r'/group/{groupId}/groupSettings'
      .replaceAll('{groupId}', groupId.toString());

    // ignore: prefer_final_locals
    Object? postBody = updateGroupSettingsCommand;

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

  /// Update group settings
  ///
  /// This will update the group settings for a group
  ///
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///   Group Id to update
  ///
  /// * [UpdateGroupSettingsCommand] updateGroupSettingsCommand (required):
  ///   Group settings to update
  Future<GroupSettings?> updateGroupSettings(int groupId, UpdateGroupSettingsCommand updateGroupSettingsCommand,) async {
    final response = await updateGroupSettingsWithHttpInfo(groupId, updateGroupSettingsCommand,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GroupSettings',) as GroupSettings;
    
    }
    return null;
  }
}
