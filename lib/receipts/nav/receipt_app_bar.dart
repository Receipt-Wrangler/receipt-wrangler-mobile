import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';

import '../../utils/forms.dart';
import '../../utils/receipts.dart';

class ReceiptAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ReceiptAppBar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  State<ReceiptAppBar> createState() => _ReceiptAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _ReceiptAppBar extends State<ReceiptAppBar> {
  @override
  Widget build(BuildContext context) {
    var uri = GoRouter.of(context).routeInformationProvider.value.uri;
    var formState = getFormState(uri.toString());
    var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
    List<Widget> actions = [...widget.actions ?? []];

    return TopAppBar(
      titleText: getTitleText(formState, receipt.name),
      leadingArrowRedirect: "/groups/${receipt.groupId}/receipts",
      actions: actions,
      hideAvatar: true,
    );
  }
}
