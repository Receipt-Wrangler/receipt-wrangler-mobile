import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';

import '../../service/file_upload.dart';
import '../../utils/forms.dart';
import '../../utils/receipts.dart';
import '../../utils/snackbar.dart';

class ReceiptAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ReceiptAppBar({super.key});

  @override
  State<ReceiptAppBar> createState() => _ReceiptAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _ReceiptAppBar extends State<ReceiptAppBar> {
  String getGroupTitleText(api.Group group) {
    if (group.name.toLowerCase().contains("receipt")) {
      return group.name;
    }

    return "${group.name} Receipts";
  }

  @override
  Widget build(BuildContext context) {
    Widget getImageUploadIcon(context, api.Receipt receipt) {
      var fullPath = GoRouterState.of(context).fullPath;

      if (fullPath == "/receipts/:receiptId/images/view") {
        return IconButton(
          icon: const Icon(Icons.add_a_photo),
          onPressed: () async {
            try {
              var filesUploaded =
                  await uploadImagesToReceipt(receipt.id.toString());
              if (filesUploaded.isNotEmpty) {
                showSuccessSnackbar(context,
                    "Successfully uploaded ${filesUploaded.length} images");
                for (var file in filesUploaded) {
                  Provider.of<ReceiptModel>(context, listen: false)
                      .pushImage(file);
                }
              }
            } catch (e) {
              print(e);
              return;
            }
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    var uri = GoRouter.of(context).routeInformationProvider.value.uri;
    var formState = getFormState(uri.toString());
    var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
    List<Widget> actions = [getImageUploadIcon(context, receipt)];

    return TopAppBar(
      titleText: getTitleText(formState, receipt.name),
      leadingArrowRedirect: "/groups/${receipt.groupId}/receipts",
      actions: actions,
    );
  }
}
