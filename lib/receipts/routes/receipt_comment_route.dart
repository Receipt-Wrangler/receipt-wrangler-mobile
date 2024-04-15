import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_comments.dart';

import '../../shared/widgets/screen_wrapper.dart';
import '../nav/receipt_app_bar.dart';
import '../nav/receipt_bottom_nav.dart';

Widget buildReceiptCommentRoute(BuildContext context, GoRouterState state) {
  return ScreenWrapper(
      appBarWidget: const ReceiptAppBar(),
      bottomNavigationBarWidget: const ReceiptBottomNav(),
      child: ReceiptComments(),
      bottomSheetWidget: buildCommentBar(context));
}

Widget buildCommentBar(BuildContext context) {
  var formKey = GlobalKey<FormBuilderState>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildCommentTextField(context, formKey),
      buildSubmitButton(formKey)
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
          onChanged: (value) {},
        )),
  );
}

Widget buildSubmitButton(GlobalKey<FormBuilderState> formKey) {
  var isValid = formKey.currentState?.saveAndValidate();
  return IconButton(
      disabledColor: Colors.grey,
      icon: Icon(
        Icons.send,
      ),
      onPressed: (isValid ?? false) ? () => submitComment(formKey) : null);
}

void submitComment(GlobalKey<FormBuilderState> formKey) {
  print("hey");
}
