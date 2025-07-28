import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/routes.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/custom_field_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../../utils/forms.dart';

class ReceiptBottomNav extends StatefulWidget {
  const ReceiptBottomNav({super.key});

  @override
  State<ReceiptBottomNav> createState() => _ReceiptBottomNav();
}

class _ReceiptBottomNav extends State<ReceiptBottomNav> {
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);
  late final customFieldModel = Provider.of<CustomFieldModel>(context, listen: false);
  var indexSelectedController = StreamController<int>();
  var imagesAddedController = StreamController<api.FileDataView>.broadcast();

  void updateModifiedReceipt() {
    var formState = getFormStateFromContext(context);
    
    // If we have a form, save its current state to the model
    if (receiptModel.receiptFormKey.currentState != null) {
      receiptModel.receiptFormKey.currentState!.save();
      var form = {...receiptModel.receiptFormKey.currentState!.value};
      
      // Update the model's form data with current form values
      form.forEach((key, value) {
        receiptModel.updateFormField(key, value);
      });
    }

    // Process custom fields - only process fields that are currently part of the receipt
    List<api.CustomFieldValue> customFieldValues = [];
    for (var existingCustomFieldValue in receiptModel.modifiedReceipt.customFields) {
      // Find the custom field template
      var customField = customFieldModel.customFields
          .where((cf) => cf.id == existingCustomFieldValue.customFieldId)
          .firstOrNull;
      
      if (customField == null) continue; // Skip if template not found
      
      var fieldKey = "customField_${customField.id}";
      var fieldValue = receiptModel.getFormField(fieldKey);
      
      // Only process if the field has a value (for text/currency fields) or for boolean/select fields
      bool shouldProcess = false;
      if (customField.type == api.CustomFieldType.BOOLEAN && fieldValue is bool) {
        shouldProcess = true;
      } else if (customField.type == api.CustomFieldType.SELECT && fieldValue is int) {
        shouldProcess = true;
      } else if (fieldValue != null && fieldValue.toString().isNotEmpty) {
        shouldProcess = true;
      }
      
      if (shouldProcess) {
        var customFieldValueBuilder = api.CustomFieldValueBuilder()
          ..id = 0  // Use 0 for new custom field values
          ..customFieldId = customField.id
          ..receiptId = receiptModel.receipt.id
          ..createdAt = DateTime.now().toIso8601String()  // Set current timestamp
          ..createdBy = 0  // Placeholder for user ID
          ..createdByString = ''  // Empty string placeholder
          ..updatedAt = '';  // Empty string placeholder
        
        // Set the appropriate value based on the field type
        switch (customField.type) {
          case api.CustomFieldType.TEXT:
            customFieldValueBuilder.stringValue = fieldValue.toString();
            break;
          case api.CustomFieldType.DATE:
            if (fieldValue is DateTime) {
              customFieldValueBuilder.dateValue = formatDate(zuluDateFormat, fieldValue);
            } else if (fieldValue is String) {
              customFieldValueBuilder.dateValue = fieldValue;
            }
            break;
          case api.CustomFieldType.SELECT:
            if (fieldValue is int) {
              customFieldValueBuilder.selectValue = fieldValue;
            }
            break;
          case api.CustomFieldType.CURRENCY:
            customFieldValueBuilder.currencyValue = fieldValue.toString();
            break;
          case api.CustomFieldType.BOOLEAN:
            if (fieldValue is bool) {
              customFieldValueBuilder.booleanValue = fieldValue;
            }
            break;
        }
        
        customFieldValues.add(customFieldValueBuilder.build());
      }
    }

    // Build the modified receipt from form data with custom fields
    var formDate = receiptModel.getFormField('date') as DateTime?;
    var dateString = "";
    
    if (formState == WranglerFormState.view) {
      dateString = receiptModel.modifiedReceipt.date;
    } else if (formDate != null) {
      dateString = formatDate(zuluDateFormat, formDate);
    } else {
      dateString = receiptModel.modifiedReceipt.date;
    }

    var modifiedReceipt = (api.ReceiptBuilder()
          ..id = receiptModel.receipt.id
          ..name = receiptModel.getFormField('name') ?? receiptModel.modifiedReceipt.name
          ..amount = receiptModel.getFormField('amount') ?? receiptModel.modifiedReceipt.amount
          ..date = dateString
          ..groupId = receiptModel.getFormField('groupId') ?? receiptModel.modifiedReceipt.groupId
          ..paidByUserId = receiptModel.getFormField('paidByUserId') ?? receiptModel.modifiedReceipt.paidByUserId
          ..status = receiptModel.getFormField('status') ?? receiptModel.modifiedReceipt.status
          ..comments = ListBuilder(receiptModel.comments ?? [])
          ..categories = ListBuilder(receiptModel.getFormField('categories') ?? receiptModel.modifiedReceipt.categories)
          ..tags = ListBuilder(receiptModel.getFormField('tags') ?? receiptModel.modifiedReceipt.tags)
          ..customFields = ListBuilder(customFieldValues))
        .build();

    receiptModel.setModifiedReceipt(modifiedReceipt!);
  }

  @override
  Widget build(BuildContext context) {
    var formState = getFormStateFromContext(context);
    var formStateName = formState.name;

    onDestinationSelected(int indexSelected) {
      var receipt = receiptModel.receipt;

      if (receiptModel.receiptFormKey.currentState != null) {
        updateModifiedReceipt();
      }

      if (formState != WranglerFormState.add) {
        switch (indexSelected) {
          case 0:
            context.go("/receipts/${receipt.id}/${formStateName}");
            break;
          default:
            context.go("/groups");
        }
      } else {
        switch (indexSelected) {
          case 0:
            context.go("/receipts/${formStateName}");
            break;
          default:
            context.go("/groups");
        }
      }
    }

    setIndexSelected() {
      var fullPath = GoRouterState.of(context).fullPath ?? "";
      if (fullPath == fullReceiptViewPath) {
        return 0;
      }


      return 0;
    }

    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.receipt),
        label: "Receipt",
      ),
    ];

    return BottomNav(
      key: const Key("receipt_bottom_nav"),
      destinations: destinations,
      onDestinationSelected: onDestinationSelected,
      getInitialSelectedIndex: setIndexSelected,
      indexSelectedController: indexSelectedController,
    );
  }

  @override
  void dispose() {
    indexSelectedController.close();
    imagesAddedController.close();
    super.dispose();
  }
}
