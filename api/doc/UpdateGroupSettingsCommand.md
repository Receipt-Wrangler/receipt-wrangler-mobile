# openapi.model.UpdateGroupSettingsCommand

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**systemEmailId** | **int** | System email foreign key | 
**emailIntegrationEnabled** | **bool** | Whether email integration is enabled | [optional] 
**subjectLineRegexes** | [**BuiltList&lt;SubjectLineRegex&gt;**](SubjectLineRegex.md) | Subject line regexes | 
**emailWhiteList** | [**BuiltList&lt;GroupSettingsWhiteListEmail&gt;**](GroupSettingsWhiteListEmail.md) | Email white list | 
**emailDefaultReceiptStatus** | [**ReceiptStatus**](ReceiptStatus.md) | Default receipt status | [optional] 
**emailDefaultReceiptPaidById** | **int** | User foreign key | [optional] 
**promptId** | **int** | Prompt foreign key | [optional] 
**fallbackPromptId** | **int** | Fallback prompt foreign key | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


