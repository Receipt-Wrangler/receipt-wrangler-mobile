import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:openapi/openapi.dart';
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:receipt_wrangler_mobile/interfaces/upload_multipart_file_data.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptModel extends ChangeNotifier {
  Receipt _receipt = getDefaultReceipt();

  Receipt get receipt => _receipt;

  Receipt _modifiedReceipt = getDefaultReceipt();

  Receipt get modifiedReceipt => _modifiedReceipt;

  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  List<FormItem> _items = [];

  List<FormItem> get items => _items;

  BehaviorSubject<List<FileDataView?>> _imageBehaviorSubject =
      BehaviorSubject<List<FileDataView?>>.seeded([]);

  BehaviorSubject<List<FileDataView?>> get imageBehaviorSubject =>
      _imageBehaviorSubject;

  BehaviorSubject<List<UploadMultipartFileData>>
      _imagesToUploadBehaviorSubject =
      BehaviorSubject<List<UploadMultipartFileData>>.seeded([]);

  BehaviorSubject<List<UploadMultipartFileData>>
      get imagesToUploadBehaviorSubject => _imagesToUploadBehaviorSubject;

  InfiniteScrollController _infiniteScrollController =
      InfiniteScrollController();

  InfiniteScrollController get infiniteScrollController =>
      _infiniteScrollController;

  // New form state storage - replaces form keys
  Map<String, dynamic> _formData = {};

  Map<String, dynamic> get formData => Map.from(_formData);

  Map<String, dynamic> _quickActionsFormData = {};

  Map<String, dynamic> get quickActionsFormData => Map.from(_quickActionsFormData);

  // Keep form keys for backward compatibility during transition
  var _receiptFormKey = GlobalKey<FormBuilderState>();

  GlobalKey<FormBuilderState> get receiptFormKey => _receiptFormKey;

  var _quickActionsFormKey = GlobalKey<FormBuilderState>();

  GlobalKey<FormBuilderState> get quickActionsFormKey => _quickActionsFormKey;

  // Form state management methods
  void updateFormField(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  dynamic getFormField(String key) {
    return _formData[key];
  }

  void updateQuickActionsFormField(String key, dynamic value) {
    _quickActionsFormData[key] = value;
    notifyListeners();
  }

  dynamic getQuickActionsFormField(String key) {
    return _quickActionsFormData[key];
  }

  void resetFormData() {
    _formData.clear();
    _quickActionsFormData.clear();
    notifyListeners();
  }

  void loadFormDataFromReceipt(Receipt receipt) {
    _loadFormDataFromReceiptInternal(receipt);
    notifyListeners();
  }

  Receipt buildReceiptFromFormData() {
    // This method will be used when we need to convert form data back to Receipt
    // (for API calls, etc.)
    return _modifiedReceipt.rebuild((b) => b
      ..name = _formData['name'] ?? _modifiedReceipt.name
      ..amount = _formData['amount'] ?? _modifiedReceipt.amount
      ..date = (_formData['date'] as DateTime?)?.toIso8601String() ?? _modifiedReceipt.date
      ..groupId = _formData['groupId'] ?? _modifiedReceipt.groupId
      ..paidByUserId = _formData['paidByUserId'] ?? _modifiedReceipt.paidByUserId
      ..status = _formData['status'] ?? _modifiedReceipt.status
      ..categories = ListBuilder(_formData['categories'] ?? _modifiedReceipt.categories)
      ..tags = ListBuilder(_formData['tags'] ?? _modifiedReceipt.tags));
  }

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    _modifiedReceipt = receipt;

    _comments = (receipt.comments)?.toList() ?? [];

    _items = FormItem.fromItems((receipt.receiptItems)?.toList() ?? []);

    _imageBehaviorSubject = BehaviorSubject<List<FileDataView?>>.seeded([]);

    _imagesToUploadBehaviorSubject =
        BehaviorSubject<List<UploadMultipartFileData>>.seeded([]);

    _receiptFormKey = GlobalKey<FormBuilderState>();

    // Load form data from the receipt (without notifying since we'll notify below)
    _loadFormDataFromReceiptInternal(receipt);

    if (notify) {
      notifyListeners();
    }
  }

  void _loadFormDataFromReceiptInternal(Receipt receipt) {
    _formData = {
      'name': receipt.name,
      'amount': receipt.amount,
      'date': DateTime.parse(receipt.date),
      'groupId': receipt.groupId,
      'paidByUserId': receipt.paidByUserId,
      'status': receipt.status,
      'categories': receipt.categories?.toList() ?? [],
      'tags': receipt.tags?.toList() ?? [],
    };
    
    // Add custom fields to form data
    for (var customFieldValue in receipt.customFields) {
      String fieldKey = "customField_${customFieldValue.customFieldId}";
      // Set the appropriate value based on what's available
      if (customFieldValue.stringValue != null) {
        _formData[fieldKey] = customFieldValue.stringValue;
      } else if (customFieldValue.dateValue != null) {
        _formData[fieldKey] = DateTime.parse(customFieldValue.dateValue!);
      } else if (customFieldValue.selectValue != null) {
        _formData[fieldKey] = customFieldValue.selectValue;
      } else if (customFieldValue.currencyValue != null) {
        _formData[fieldKey] = customFieldValue.currencyValue;
      } else if (customFieldValue.booleanValue != null) {
        _formData[fieldKey] = customFieldValue.booleanValue;
      }
    }
  }

  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }

  void setItems(List<FormItem> items) {
    _items = items;
    notifyListeners();
  }

  void setModifiedReceipt(Receipt receipt) {
    _modifiedReceipt = receipt;
    notifyListeners();
  }

  void resetQuickActionsFormKey() {
    _quickActionsFormKey = GlobalKey<FormBuilderState>();
  }

  void resetModel() {
    _receipt = getDefaultReceipt();
    _modifiedReceipt = getDefaultReceipt();
    _comments = [];
    _items = [];
    _imageBehaviorSubject = BehaviorSubject<List<FileDataView?>>.seeded([]);
    _imagesToUploadBehaviorSubject =
        BehaviorSubject<List<UploadMultipartFileData>>.seeded([]);
    _infiniteScrollController = InfiniteScrollController();
    _receiptFormKey = GlobalKey<FormBuilderState>();
    
    // Reset form data
    _formData.clear();
    _quickActionsFormData.clear();
  }
}
