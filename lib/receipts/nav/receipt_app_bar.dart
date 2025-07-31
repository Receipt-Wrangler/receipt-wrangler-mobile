import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top_app_bar.dart';

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
    List<Widget> actions = [...widget.actions ?? []];

    // TODO: fix add redirect
    // Use Selector to only rebuild when receipt name or groupId changes
    return Selector<ReceiptModel, ({String name, int groupId})>(
        selector: (context, model) =>
            (name: model.receipt.name, groupId: model.receipt.groupId),
        shouldRebuild: (previous, next) =>
            previous.name != next.name || previous.groupId != next.groupId,
        builder: (context, data, child) {
          return TopAppBar(
            titleText: getTitleText(formState, data.name),
            leadingArrowRedirect: formState == WranglerFormState.add
                ? "/groups"
                : "/groups/${data.groupId}/receipts",
            leadingArrowPop: false,
            onLeadingArrowPressed: null,
            actions: actions,
            hideAvatar: true,
          );
        });
  }
}
