//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommentApi {
  CommentApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Add comment
  ///
  /// This will add a comment to a receipt, [SYSTEM USER]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Comment] comment (required):
  ///   Comment to create
  Future<Response> addCommentWithHttpInfo(Comment comment,) async {
    // ignore: prefer_const_declarations
    final path = r'/comment/';

    // ignore: prefer_final_locals
    Object? postBody = comment;

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

  /// Add comment
  ///
  /// This will add a comment to a receipt, [SYSTEM USER]
  ///
  /// Parameters:
  ///
  /// * [Comment] comment (required):
  ///   Comment to create
  Future<void> addComment(Comment comment,) async {
    final response = await addCommentWithHttpInfo(comment,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete comment
  ///
  /// This will delete a comment by id [SYSTEM User]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] commentId (required):
  ///   Comment Id to delete
  Future<Response> deleteCommentWithHttpInfo(int commentId,) async {
    // ignore: prefer_const_declarations
    final path = r'/comment/{commentId}'
      .replaceAll('{commentId}', commentId.toString());

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

  /// Delete comment
  ///
  /// This will delete a comment by id [SYSTEM User]
  ///
  /// Parameters:
  ///
  /// * [int] commentId (required):
  ///   Comment Id to delete
  Future<void> deleteComment(int commentId,) async {
    final response = await deleteCommentWithHttpInfo(commentId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
