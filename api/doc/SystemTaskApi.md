# openapi.api.SystemTaskApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPagedSystemTasks**](SystemTaskApi.md#getpagedsystemtasks) | **POST** /systemTask/getPagedSystemTasks | Gets paged system tasks


# **getPagedSystemTasks**
> PagedData getPagedSystemTasks(getSystemTaskCommand)

Gets paged system tasks

This will return paged system tasks

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSystemTaskApi();
final GetSystemTaskCommand getSystemTaskCommand = ; // GetSystemTaskCommand | Paging and sorting data

try {
    final response = api.getPagedSystemTasks(getSystemTaskCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SystemTaskApi->getPagedSystemTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getSystemTaskCommand** | [**GetSystemTaskCommand**](GetSystemTaskCommand.md)| Paging and sorting data | 

### Return type

[**PagedData**](PagedData.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

