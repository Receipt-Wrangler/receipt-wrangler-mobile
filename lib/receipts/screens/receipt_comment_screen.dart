import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/receipt_model.dart';
import '../../shared/widgets/screen_wrapper.dart';
import '../../utils/forms.dart';
import '../../utils/receipts.dart';
import '../nav/receipt_app_bar.dart';
import '../nav/receipt_bottom_nav.dart';
import '../widgets/receipt_comments.dart';

class ReceiptCommentScreen extends StatefulWidget {
  const ReceiptCommentScreen({super.key});

  @override
  State<ReceiptCommentScreen> createState() => _ReceiptCommentScreenState();
}

class _ReceiptCommentScreenState extends State<ReceiptCommentScreen> {
  final textBehaviorSubject = BehaviorSubject<String>();
  final commentsBehaviorSubject = BehaviorSubject<List<api.Comment>>();
  late final formState = getFormStateFromContext(context);
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildCommentBar(BuildContext context) {
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
        var comments = [...commentsBehaviorSubject.value];
        comments.add(value as api.Comment);

        commentsBehaviorSubject.add(comments);
        textBehaviorSubject.add("");
        formKey.currentState?.reset();
      }).catchError((error) {
        print(error);
        handleApiError(context, error);
      });
    }
  }

  Widget buildMenuButton() {
    switch (formState) {
      case WranglerFormState.create:
      case WranglerFormState.edit:
        return const SizedBox.shrink();
      case WranglerFormState.view:
        return PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Edit"),
                onTap: () {
                  var receiptModel =
                      Provider.of<ReceiptModel>(context, listen: false);
                  var receipt = receiptModel.receipt;
                  context.go("/receipts/${receipt.id}/comments/edit");
                },
              )
            ];
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    commentsBehaviorSubject.add(receipt.comments);

    return ScreenWrapper(
        appBarWidget: ReceiptAppBar(
          actions: [buildMenuButton()],
        ),
        bottomNavigationBarWidget: const ReceiptBottomNav(),
        child: StreamBuilder(
            stream: commentsBehaviorSubject,
            builder: (context, snapshot) {
              return ReceiptComments(comments: snapshot.data ?? []);
            }),
        bottomSheetWidget: formState == WranglerFormState.view
            ? null
            : buildCommentBar(context));
  }
}
