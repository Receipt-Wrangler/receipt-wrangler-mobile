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

  Map<String, dynamic> _quickActionsFormData = {};

  Map<String, dynamic> get quickActionsFormData =>
      Map.from(_quickActionsFormData);

  // UI state flags for form interactions - use ValueNotifiers to avoid full rebuilds
  ValueNotifier<bool> _isAddingShareNotifier = ValueNotifier(false);

  ValueNotifier<bool> get isAddingShareNotifier => _isAddingShareNotifier;

  bool get isAddingShare => _isAddingShareNotifier.value;

  ValueNotifier<bool> _isAddingItemNotifier = ValueNotifier(false);

  ValueNotifier<bool> get isAddingItemNotifier => _isAddingItemNotifier;

  bool get isAddingItem => _isAddingItemNotifier.value;

  var _quickActionsFormKey = GlobalKey<FormBuilderState>();

  GlobalKey<FormBuilderState> get quickActionsFormKey => _quickActionsFormKey;

  // Split context for quick actions - tracks what is being split
  String? _splitAmount;
  String? _splitItemFormId; // null = splitting receipt, non-null = splitting specific item

  String? get splitAmount => _splitAmount;
  String? get splitItemFormId => _splitItemFormId;

  void setSplitAmount(String? amount) {
    _splitAmount = amount;
    notifyListeners();
  }

  void setSplitItemFormId(String? formId) {
    _splitItemFormId = formId;
    notifyListeners();
  }

  bool get isSplittingReceipt => _splitItemFormId == null;
  bool get isSplittingItem => _splitItemFormId != null;

  bool _syncWithItems = false;

  bool get syncWithItems => _syncWithItems;

  void setSyncWithItems(bool value) {
    _syncWithItems = value;
    if (value) {
      _updateAmountFromItems();
    }
    notifyListeners();
  }

  void _updateAmountFromItems() {
    if (!_syncWithItems) return;
    
    double total = calculateItemsTotal(_items);
    
    // Update the modified receipt with new amount
    _modifiedReceipt = _modifiedReceipt.rebuild((b) => b..amount = total.toStringAsFixed(2));
    notifyListeners();
  }

  // Form state management methods for quick actions only

  void updateQuickActionsFormField(String key, dynamic value) {
    _quickActionsFormData[key] = value;
    notifyListeners();
  }

  dynamic getQuickActionsFormField(String key) {
    return _quickActionsFormData[key];
  }

  // UI state management methods - update ValueNotifiers without triggering full rebuilds
  void setIsAddingShare(bool value) {
    _isAddingShareNotifier.value = value;
  }

  void setIsAddingItem(bool value) {
    _isAddingItemNotifier.value = value;
  }

  void resetQuickActionsFormData() {
    _quickActionsFormData.clear();
    notifyListeners();
  }

  void setReceipt(Receipt receipt, bool notify) {
    _receipt = receipt;

    _modifiedReceipt = receipt;

    _comments = (receipt.comments)?.toList() ?? [];

    _items = FormItem.fromItems((receipt.receiptItems)?.toList() ?? []);

    _imageBehaviorSubject = BehaviorSubject<List<FileDataView?>>.seeded([]);

    _imagesToUploadBehaviorSubject =
        BehaviorSubject<List<UploadMultipartFileData>>.seeded([]);

    // Reset UI state flags when switching receipts
    _isAddingShareNotifier.value = false;
    _isAddingItemNotifier.value = false;
    _syncWithItems = false;

    if (notify) {
      notifyListeners();
    }
  }


  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }

  void setItems(List<FormItem> items) {
    _items = items;
    if (_syncWithItems) {
      _updateAmountFromItems();
    }
    notifyListeners();
  }

  void setModifiedReceipt(Receipt receipt) {
    _modifiedReceipt = receipt;
    notifyListeners();
  }

  void resetQuickActionsFormKey() {
    _quickActionsFormKey = GlobalKey<FormBuilderState>();
    _splitAmount = null;
    _splitItemFormId = null;
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

    // Reset quick actions form data
    _quickActionsFormData.clear();

    // Reset UI state flags
    _isAddingShareNotifier.value = false;
    _isAddingItemNotifier.value = false;
    _syncWithItems = false;
    
    // Reset split context
    _splitAmount = null;
    _splitItemFormId = null;
  }
}
