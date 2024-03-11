import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';

import '../../utils/forms.dart';
import '../../utils/receipts.dart';

class ReceiptAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ReceiptAppBar({super.key, required this.receipt});

  final api.Receipt receipt;

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
    var uri = GoRouter.of(context).routeInformationProvider.value.uri;
    var formState = getFormState(uri.toString());

    return TopAppBar(
      titleText: getTitleText(formState, widget.receipt.name),
      leadingArrowRedirect: "/groups/${widget.receipt.groupId}/receipts",
    );
  }
}
