import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:rxdart/rxdart.dart';

import '../../api.dart' as api;
import '../../models/auth_model.dart';
import '../../models/receipt_model.dart';
import '../../shared/widgets/bottom_submit_button.dart';
import '../../utils/date.dart';
import '../../utils/forms.dart';
import '../../utils/receipts.dart';
import '../../utils/snackbar.dart';

class ReceiptBottomSheetBuilder {
  late final ReceiptModel receiptModel;

  late final BuildContext context;

  late final textBehaviorSubject = BehaviorSubject<String>();

  late final formState = getFormStateFromContext(context);

  ReceiptBottomSheetBuilder(BuildContext context, ReceiptModel receiptModel) {
    this.context = context;
    this.receiptModel = receiptModel;
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

    var comment = api.Comment(
        id: 0,
        comment: commentText,
        receiptId: 0,
        userId: userId,
        createdAt: new DateTime.now().toString());

    var comments = [...receiptModel.comments];
    comments.add(comment);

    receiptModel.setComments(comments);
  }

  void submitCommentToApi(GlobalKey<FormBuilderState> formKey) {
    var comment = formKey.currentState?.value['comment'];
    var receiptId = int.parse(getReceiptId(context) ?? "0");

    var command =
        api.UpsertCommentCommand(comment: comment, receiptId: receiptId);

    api.CommentApi().addComment(command).then((value) {
      var comments = [...receiptModel.comments];
      comments.add(value as api.Comment);

      receiptModel.setComments(comments);
      textBehaviorSubject.add("");
      formKey.currentState?.reset();
    }).catchError((error) {
      print(error);
      handleApiError(context, error);
    });
  }

  List<api.UpsertCategoryCommand> buildUpsertCategoryCommand(
      Map<String, dynamic> form) {
    var categories = List<api.Category>.from(
        form["categories"].map((item) => item as api.Category));

    return categories
        .map((category) => api.UpsertCategoryCommand(
            id: category.id,
            name: category.name ?? "",
            description: category.description ?? ""))
        .toList();
  }

  List<api.UpsertTagCommand> buildUpsertTagCommand(Map<String, dynamic> form) {
    // TODO: move these into shared funcs
    var tags = List<api.Tag>.from(form["tags"].map((item) => item as api.Tag));

    return tags
        .map((tag) => api.UpsertTagCommand(
            id: tag.id,
            name: tag.name ?? "",
            description: tag.description ?? ""))
        .toList();
  }

  List<api.UpsertItemCommand> buildUpsertItemCommand(
      Map<String, dynamic> form) {
    var items = Provider.of<ReceiptModel>(context, listen: false).items;
    List<api.UpsertItemCommand> upsertItems = [];

    for (var i = 0; i < items.length; i++) {
      var item = items[i];

      var itemName = FormItem.buildItemNameName(item);
      var amountName = FormItem.buildItemAmountName(item);
      var statusName = FormItem.buildItemStatusName(item);

      var command = api.UpsertItemCommand(
        amount: form[amountName],
        chargedToUserId: item.chargedToUserId,
        name: form[itemName],
        receiptId: item?.receiptId ?? 0,
        status: form[statusName],
      );

      upsertItems.add(command);
    }

    return upsertItems;
  }

  List<api.UpsertCommentCommand> buildCommentUpsertCommand() {
    var comments = Provider.of<ReceiptModel>(context, listen: false).comments;
    List<api.UpsertCommentCommand> upsertComments = [];

    for (var i = 0; i < comments.length; i++) {
      var comment = comments[i];

      var command = api.UpsertCommentCommand(
        receiptId: comment.receiptId,
        userId: comment.userId,
        comment: comment.comment,
      );

      upsertComments.add(command);
    }

    return upsertComments;
  }

  api.UpsertReceiptCommand buildReceiptUpsertCommand() {
    var form = {...receiptModel.receiptFormKey.currentState!.value};

    var date = form["date"] as DateTime;
    form["date"] = formatDate(zuluDateFormat, date);

    var status = form["status"] as api.ReceiptStatus;
    form["status"] = status.value;

    var receiptToUpdate =
        api.UpsertReceiptCommand.fromJson(form) as api.UpsertReceiptCommand;

    receiptToUpdate.categories = buildUpsertCategoryCommand(form);
    receiptToUpdate.tags = buildUpsertTagCommand(form);
    receiptToUpdate.receiptItems = buildUpsertItemCommand(form);

    if (formState == WranglerFormState.add) {
      receiptToUpdate.comments = buildCommentUpsertCommand();
    }

    return receiptToUpdate;
  }

  Future<void> addReceipt(api.UpsertReceiptCommand receiptToAdd) async {
    var receipt = await api.ReceiptApi().createReceipt(receiptToAdd);
    showSuccessSnackbar(context, "Receipt added successfully");

    var images = receiptModel.imagesToUploadBehaviorSubject.value;
    List<Future<api.FileDataView?>> imageFutures = [];

    for (var image in images) {
      imageFutures.add(api.ReceiptImageApi()
          .uploadReceiptImage(image.multipartFile, receipt!.id));
    }
    await Future.wait(imageFutures);

    context.go("/receipts/${receipt!.id}/view");
  }

  Future<void> updateReceipt(api.UpsertReceiptCommand receiptToUpdate) async {
    var receipt = receiptModel.receipt;
    var updatedReceipt =
        await api.ReceiptApi().updateReceipt(receipt.id, receiptToUpdate);
    showSuccessSnackbar(context, "Receipt updated successfully");

    receiptModel.setReceipt(updatedReceipt as api.Receipt, true);
    context.go("/receipts/${receipt.id}/view");
  }

  Widget buildReceiptSubmitButton(String fullPath) {
    if (isEditingBasedOnFullPath(fullPath)) {
      return BottomSubmitButton(
        onPressed: () async {
          if (receiptModel.receiptFormKey.currentState!.saveAndValidate()) {
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
          }
        },
      );
    }

    return SizedBox.shrink();
  }
}
