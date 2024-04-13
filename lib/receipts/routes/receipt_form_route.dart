import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../../api.dart' as api;
import '../../models/receipt_model.dart';
import '../../shared/widgets/bottom_submit_button.dart';
import '../../shared/widgets/circular_loading_progress.dart';
import '../../shared/widgets/screen_wrapper.dart';
import '../../shared/widgets/top-app-bar.dart';
import '../../utils/forms.dart';
import '../../utils/receipts.dart';
import '../../utils/snackbar.dart';
import '../nav/receipt_bottom_nav.dart';

Widget buildMenuButton(BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Text("Edit"),
          onTap: () {
            var receiptModel =
                Provider.of<ReceiptModel>(context, listen: false);
            var receipt = receiptModel.receipt;
            context.go("/receipts/${receipt.id}/edit");
          },
        )
      ];
    },
  );
}

PreferredSizeWidget buildAppBarWidget(
    BuildContext context, WranglerFormState formState, api.Receipt receipt) {
  return TopAppBar(
    titleText: getTitleText(formState, receipt.name),
    leadingArrowRedirect: "/groups/${receipt.groupId}/receipts",
    actions: [buildMenuButton(context)],
    hideAvatar: true,
  );
}

Widget buildReceiptFormRoute(BuildContext context, GoRouterState state) {
  var future = api.ReceiptApi()
      .getReceiptById(int.parse(state.pathParameters['receiptId'] as String));
  final formKey = GlobalKey<FormBuilderState>();

  return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var formState = getFormStateFromContext(context);
          var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
          receiptModel.setReceipt(snapshot.data as api.Receipt, false);

          return ScreenWrapper(
            appBarWidget:
                buildAppBarWidget(context, formState, receiptModel.receipt),
            bottomNavigationBarWidget: const ReceiptBottomNav(),
            child: SingleChildScrollView(
              child: ReceiptForm(
                formKey: formKey,
              ),
            ),
            bottomSheetWidget: formState == WranglerFormState.edit
                ? buildSubmitButton(context, formKey)
                : null,
          );
        }

        return const CircularLoadingProgress();
      });
}

Widget buildSubmitButton(
    BuildContext context, GlobalKey<FormBuilderState> formKey) {
  return BottomSubmitButton(
    onPressed: () async {
      if (formKey.currentState!.saveAndValidate()) {
        var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
        var form = {...formKey.currentState!.value};

        try {
          var date = form["date"] as DateTime;
          form["date"] = formatDate(zuluDateFormat, date);

          var status = form["status"] as api.ReceiptStatus;
          form["status"] = status.value;

          var receiptToUpdate = api.UpsertReceiptCommand.fromJson(form)
              as api.UpsertReceiptCommand;

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
