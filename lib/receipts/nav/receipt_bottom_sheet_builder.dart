import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:rxdart/rxdart.dart';

import '../../client/client.dart';
import '../../models/auth_model.dart';
import '../../models/custom_field_model.dart';
import '../../models/receipt_model.dart';
import '../../shared/widgets/bottom_submit_button.dart';
import '../../utils/date.dart';
import '../../utils/forms.dart';
import '../../utils/receipts.dart';
import '../../utils/snackbar.dart';

class ReceiptBottomSheetBuilder {
  late final ReceiptModel receiptModel;

  late final BuildContext context;

  late final GlobalKey<FormBuilderState> formKey;

  late final textBehaviorSubject = BehaviorSubject<String>();

  late final formState = getFormStateFromContext(context);

  ReceiptBottomSheetBuilder(BuildContext context, ReceiptModel receiptModel, GlobalKey<FormBuilderState> formKey) {
    this.context = context;
    this.receiptModel = receiptModel;
    this.formKey = formKey;
  }

  Widget buildBottomSheet(GoRouterState state) {
    if (state.fullPath!.contains("images")) {
      return SizedBox.shrink();
    } else if (state.fullPath!.contains("comments")) {
      return buildCommentBottomBar(state.fullPath!);
    } else {
      return buildReceiptSubmitButton(state.fullPath!);
    }
  }

  Widget buildCommentBottomBar(String fullPath) {
    if (isEditingBasedOnFullPath(fullPath)) {
      return buildCommentBar();
    }

    return SizedBox.shrink();
  }

  Widget buildCommentBar() {
    var formKey = GlobalKey<FormBuilderState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCommentTextField(context, formKey),
        StreamBuilder(
            stream: textBehaviorSubject.stream,
            builder: (context, snapshot) {
              return buildSubmitButton(formKey, snapshot.data);
            }),
      ],
    );
  }

  Widget buildCommentTextField(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return Expanded(
      child: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: "comment",
            decoration: const InputDecoration(labelText: "Comment"),
            validator: FormBuilderValidators.required(),
            onChanged: (value) {
              textBehaviorSubject.add(value ?? "");
            },
          )),
    );
  }

  Widget buildSubmitButton(
      GlobalKey<FormBuilderState> formKey, String? comment) {
    var isValid = comment?.isNotEmpty;
    return IconButton(
        icon: Icon(
          Icons.send,
        ),
        onPressed: (isValid ?? false) ? () => submitComment(formKey) : null);
  }

  void submitComment(GlobalKey<FormBuilderState> formKey) async {
    var formState = getFormStateFromContext(context);
    if (formKey.currentState?.saveAndValidate() ?? false) {
      if (formState == WranglerFormState.edit) {
        submitCommentToApi(formKey);
      } else if (formState == WranglerFormState.add) {
        addCommentToModel(formKey);
      }
    }
  }

  void addCommentToModel(GlobalKey<FormBuilderState> formKey) {
    var commentText = formKey.currentState?.value['comment'];
    var userId =
        Provider.of<AuthModel>(context, listen: false).claims?.userId ?? 0;

    var comment = (api.CommentBuilder()
          ..id = 0
          ..comment = commentText
          ..receiptId = 0
          ..userId = userId
          ..createdAt = DateTime.now().toString())
        .build();

    var comments = [...receiptModel.comments];
    comments.add(comment);

    receiptModel.setComments(comments);
  }

  void submitCommentToApi(GlobalKey<FormBuilderState> formKey) {
    var comment = formKey.currentState?.value['comment'];
    var receiptId = int.parse(getReceiptId(context) ?? "0");

    var command = (api.UpsertCommentCommandBuilder()
          ..comment = comment
          ..receiptId = receiptId)
        .build();

    OpenApiClient.client
        .getCommentApi()
        .addComment(upsertCommentCommand: command)
        .then((value) {
      var comments = [...receiptModel.comments];
      comments.add(value.data as api.Comment);

      receiptModel.setComments(comments);
      textBehaviorSubject.add("");
      formKey.currentState?.reset();
    }).catchError((error) {
      print(error);
      handleApiError(context, error);
    });
  }

  List<api.UpsertCategoryCommand> buildUpsertCategoryCommand(
      Map<String, dynamic> form, String name) {
    // Handle null or missing form fields
    if (form[name] == null) {
      return [];
    }
    
    var categories =
        List<api.Category>.from(form[name].map((item) => item as api.Category));

    return categories
        .map((category) => (api.UpsertCategoryCommandBuilder()
              ..id = category.id
              ..name = category.name ?? ""
              ..description = category.description ?? "")
            .build())
        .toList();
  }

  List<api.UpsertTagCommand> buildUpsertTagCommand(
      Map<String, dynamic> form, name) {
    // TODO: move these into shared funcs
    // Handle null or missing form fields
    if (form[name] == null) {
      return [];
    }
    
    var tags = List<api.Tag>.from(form[name].map((item) => item as api.Tag));

    return tags
        .map((tag) => (api.UpsertTagCommandBuilder()
              ..id = tag.id
              ..name = tag.name ?? ""
              ..description = tag.description ?? "")
            .build())
        .toList();
  }

  api.UpsertItemCommand buildSingleUpsertItemCommand(
      FormItem item, Map<String, dynamic> form) {
    var itemName = FormItem.buildItemNameName(item);
    var amountName = FormItem.buildItemAmountName(item);
    var statusName = FormItem.buildItemStatusName(item);
    var categoryName = FormItem.buildItemCategoryName(item);
    var tagName = FormItem.buildItemTagName(item);

    // Recursively build linked items (one level deep only as per API spec)
    List<api.UpsertItemCommand> linkedCommands = [];
    if (item.linkedItems.isNotEmpty) {
      for (var linkedItem in item.linkedItems) {
        // Build linked item without further recursion (one level deep only)
        var linkedItemName = FormItem.buildItemNameName(linkedItem);
        var linkedAmountName = FormItem.buildItemAmountName(linkedItem);
        var linkedStatusName = FormItem.buildItemStatusName(linkedItem);
        var linkedCategoryName = FormItem.buildItemCategoryName(linkedItem);
        var linkedTagName = FormItem.buildItemTagName(linkedItem);
        
        // Check if form fields exist for this linked item
        // If not, use the linkedItem's existing data directly
        var linkedCommand = (api.UpsertItemCommandBuilder()
              ..amount = form.containsKey(linkedAmountName) 
                  ? form[linkedAmountName] 
                  : linkedItem.amount
              ..chargedToUserId = linkedItem.chargedToUserId
              ..name = form.containsKey(linkedItemName) 
                  ? form[linkedItemName] 
                  : linkedItem.name
              ..receiptId = linkedItem.receiptId
              ..status = form.containsKey(linkedStatusName) 
                  ? form[linkedStatusName] 
                  : linkedItem.status
              ..categories = form.containsKey(linkedCategoryName)
                  ? ListBuilder(buildUpsertCategoryCommand(form, linkedCategoryName))
                  : ListBuilder(linkedItem.categories.map((cat) => 
                      (api.UpsertCategoryCommandBuilder()
                        ..id = cat.id
                        ..name = cat.name ?? ""
                        ..description = cat.description ?? "")
                      .build()))
              ..tags = form.containsKey(linkedTagName)
                  ? ListBuilder(buildUpsertTagCommand(form, linkedTagName))
                  : ListBuilder(linkedItem.tags.map((tag) => 
                      (api.UpsertTagCommandBuilder()
                        ..id = tag.id  
                        ..name = tag.name ?? ""
                        ..description = tag.description ?? "")
                      .build())))
            .build();
        linkedCommands.add(linkedCommand);
      }
    }

    var command = (api.UpsertItemCommandBuilder()
          ..amount = form[amountName]
          ..chargedToUserId = item.chargedToUserId
          ..name = form[itemName]
          ..receiptId = item.receiptId
          ..status = form[statusName]
          ..categories =
              ListBuilder(buildUpsertCategoryCommand(form, categoryName))
          ..tags = ListBuilder(buildUpsertTagCommand(form, tagName))
          ..linkedItems = linkedCommands.isNotEmpty ? ListBuilder(linkedCommands) : null)
        .build();

    return command;
  }

  List<api.UpsertItemCommand> buildUpsertItemCommand(
      Map<String, dynamic> form) {
    var items = Provider.of<ReceiptModel>(context, listen: false).items;
    List<api.UpsertItemCommand> upsertItems = [];

    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      // Only add top-level items (not linked items, as they're handled recursively)
      // Items with chargedToUserId are shares and should still be included at top level
      var command = buildSingleUpsertItemCommand(item, form);
      upsertItems.add(command);
    }

    return upsertItems;
  }

  List<api.UpsertCommentCommand> buildCommentUpsertCommand() {
    var comments = Provider.of<ReceiptModel>(context, listen: false).comments;
    List<api.UpsertCommentCommand> upsertComments = [];

    for (var i = 0; i < comments.length; i++) {
      var comment = comments[i];

      var command = (api.UpsertCommentCommandBuilder()
            ..receiptId = comment.receiptId
            ..userId = comment.userId
            ..comment = comment.comment)
          .build();

      upsertComments.add(command);
    }

    return upsertComments;
  }

  List<api.UpsertCustomFieldValueCommand> buildCustomFieldValueUpsertCommand(
      Map<String, dynamic> form) {
    var customFieldModel =
        Provider.of<CustomFieldModel>(context, listen: false);
    List<api.UpsertCustomFieldValueCommand> upsertCustomFieldValues = [];

    // Process custom field values - only process fields that are currently part of the receipt
    for (var existingCustomFieldValue
        in receiptModel.modifiedReceipt.customFields) {
      // Find the custom field template
      var customField = customFieldModel.customFields
          .where((cf) => cf.id == existingCustomFieldValue.customFieldId)
          .firstOrNull;

      if (customField == null) continue; // Skip if template not found

      var fieldKey = "customField_${customField.id}";
      var fieldValue = form[fieldKey];

      // Only process if the field has a value (for text/currency fields) or for boolean/select fields
      bool shouldProcess = false;
      if (customField.type == api.CustomFieldType.BOOLEAN &&
          fieldValue is bool) {
        shouldProcess = true;
      } else if (customField.type == api.CustomFieldType.SELECT &&
          fieldValue is int) {
        shouldProcess = true;
      } else if (fieldValue != null && fieldValue.toString().isNotEmpty) {
        shouldProcess = true;
      }

      if (shouldProcess) {
        var customFieldValueBuilder = api.UpsertCustomFieldValueCommandBuilder()
          ..customFieldId = customField.id
          ..receiptId = receiptModel.receipt.id;

        // Set the appropriate value based on the field type
        switch (customField.type) {
          case api.CustomFieldType.TEXT:
            customFieldValueBuilder.stringValue = fieldValue.toString();
            break;
          case api.CustomFieldType.DATE:
            if (fieldValue is DateTime) {
              customFieldValueBuilder.dateValue =
                  formatDate(zuluDateFormat, fieldValue);
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

        upsertCustomFieldValues.add(customFieldValueBuilder.build());
      }
    }

    return upsertCustomFieldValues;
  }

  api.UpsertReceiptCommand buildReceiptUpsertCommand() {
    var form = {...formKey.currentState!.value};

    var date = form["date"] as DateTime;
    form["date"] = formatDate(zuluDateFormat, date);

    var receiptToUpdate = (api.UpsertReceiptCommandBuilder()
      ..name = form["name"]
      ..date = form["date"]
      ..amount = form["amount"]
      ..status = form["status"]
      ..groupId = form["groupId"]
      ..paidByUserId = form["paidByUserId"]
      ..status = form["status"]);

    receiptToUpdate.categories =
        ListBuilder(buildUpsertCategoryCommand(form, "categories"));
    receiptToUpdate.tags = ListBuilder(buildUpsertTagCommand(form, "tags"));
    receiptToUpdate.receiptItems = ListBuilder(buildUpsertItemCommand(form));

    if (formState == WranglerFormState.add) {
      receiptToUpdate.comments = ListBuilder(buildCommentUpsertCommand());
    }

    // Add custom field values
    receiptToUpdate.customFields =
        ListBuilder(buildCustomFieldValueUpsertCommand(form));

    return receiptToUpdate.build();
  }

  Future<void> addReceipt(api.UpsertReceiptCommand receiptToAdd) async {
    var receiptResponse = await OpenApiClient.client
        .getReceiptApi()
        .createReceipt(upsertReceiptCommand: receiptToAdd);
    showSuccessSnackbar(context, "Receipt added successfully");

    var images = receiptModel.imagesToUploadBehaviorSubject.value;
    List<Future<Response<api.FileDataView?>>> imageFutures = [];

    for (var image in images) {
      var future = OpenApiClient.client.getReceiptImageApi().uploadReceiptImage(
          file: image.multipartFile, receiptId: receiptResponse.data!.id);
      imageFutures.add(future);
    }
    await Future.wait(imageFutures);

    context.go("/receipts/${receiptResponse.data!.id}/view");
  }

  Future<void> updateReceipt(api.UpsertReceiptCommand receiptToUpdate) async {
    var receipt = receiptModel.receipt;
    var updatedReceiptResponse = await OpenApiClient.client
        .getReceiptApi()
        .updateReceipt(
            receiptId: receipt.id, upsertReceiptCommand: receiptToUpdate);
    showSuccessSnackbar(context, "Receipt updated successfully");

    receiptModel.setReceipt(updatedReceiptResponse.data as api.Receipt, true);
    context.go("/receipts/${receipt.id}/view");
  }

  Widget buildReceiptSubmitButton(String fullPath) {
    if (isEditingBasedOnFullPath(fullPath)) {
      return BottomSubmitButton(
        onPressed: () async {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            try {
              var receiptToUpdate = buildReceiptUpsertCommand();

              if (formState == WranglerFormState.add) {
                await addReceipt(receiptToUpdate);
              } else if (formState == WranglerFormState.edit) {
                await updateReceipt(receiptToUpdate);
              }
            } catch (e) {
              handleApiError(context, e);
              print(e);
            }
          } else {
            print(formKey.currentState);
          }
        },
      );
    }

    return SizedBox.shrink();
  }
}
