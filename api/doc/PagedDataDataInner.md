# openapi.model.PagedDataDataInner

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amount** | **String** | Receipt total amount | 
**categories** | [**BuiltList&lt;Category&gt;**](Category.md) | Categories associated to receipt | [optional] 
**comments** | [**BuiltList&lt;Comment&gt;**](Comment.md) | Comments associated to receipt | [optional] 
**createdAt** | **String** |  | [optional] 
**createdBy** | **int** |  | [optional] 
**date** | **String** | Receipt date | 
**groupId** | **int** | Group foreign key | 
**id** | **int** |  | 
**imageFiles** | [**BuiltList&lt;FileData&gt;**](FileData.md) | Files associated to receipt | [optional] 
**name** | **String** | Tag name | 
**paidByUserId** | **int** | User paid foreign key | 
**receiptItems** | [**BuiltList&lt;Item&gt;**](Item.md) | Items associated to receipt | [optional] 
**resolvedDate** | **String** | Date resolved | [optional] 
**status** | [**ReceiptStatus**](ReceiptStatus.md) |  | 
**tags** | [**BuiltList&lt;Tag&gt;**](Tag.md) | Tags associated to receipt | [optional] 
**updatedAt** | **String** |  | [optional] 
**createdByString** | **String** | Created by string, which is anything that is not a user | [optional] 
**description** | **String** | Tag description | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


