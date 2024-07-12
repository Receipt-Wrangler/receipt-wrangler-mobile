import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../api.dart' as api;
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
    if (formKey.currentState?.saveAndValidate() ?? false) {
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

      var command = api.UpsertItemCommand(
        amount: form["items.${i.toString()}.amount"],
        chargedToUserId: item.chargedToUserId,
        name: form["items.${i.toString()}.name"],
        receiptId: item?.receiptId ?? 0,
        status: form["items.${i.toString()}.status"],
      );

      upsertItems.add(command);
    }

    return upsertItems;
  }

  Widget buildReceiptSubmitButton(String fullPath) {
    if (isEditingBasedOnFullPath(fullPath)) {
      return BottomSubmitButton(
        onPressed: () async {
          if (receiptModel.receiptFormKey.currentState!.saveAndValidate()) {
            var receipt = receiptModel.receipt;
            var form = {...receiptModel.receiptFormKey.currentState!.value};

            try {
              var date = form["date"] as DateTime;
              form["date"] = formatDate(zuluDateFormat, date);

              var status = form["status"] as api.ReceiptStatus;
              form["status"] = status.value;

              var receiptToUpdate = api.UpsertReceiptCommand.fromJson(form)
                  as api.UpsertReceiptCommand;

              receiptToUpdate.categories = buildUpsertCategoryCommand(form);
              receiptToUpdate.tags = buildUpsertTagCommand(form);
              receiptToUpdate.receiptItems = buildUpsertItemCommand(form);

              await api.ReceiptApi().updateReceipt(receipt.id, receiptToUpdate);
              showSuccessSnackbar(context, "Receipt updated successfully");
              context.go("/receipts/${receipt.id}/view");
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
