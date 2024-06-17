//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ImportApi {
  ImportApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Import config json
  ///
  /// This will import a config json
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///   Files to quick scan
  Future<Response> importConfigJsonWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final path = r'/import/importConfigJson';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

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

  /// Import config json
  ///
  /// This will import a config json
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  ///   Files to quick scan
  Future<void> importConfigJson(MultipartFile file,) async {
    final response = await importConfigJsonWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
