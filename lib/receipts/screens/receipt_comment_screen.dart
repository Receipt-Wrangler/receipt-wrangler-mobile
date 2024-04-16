import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:rxdart/rxdart.dart';

import '../../shared/widgets/screen_wrapper.dart';
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

  void submitComment(GlobalKey<FormBuilderState> formKey) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      var comment = formKey.currentState?.value['comment'];

      // TODO: remove userId
      api.UpsertCommentCommand(comment: comment, receiptId: 1, userId: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        appBarWidget: const ReceiptAppBar(),
        bottomNavigationBarWidget: const ReceiptBottomNav(),
        child: ReceiptComments(),
        bottomSheetWidget: buildCommentBar(context));
  }
}
