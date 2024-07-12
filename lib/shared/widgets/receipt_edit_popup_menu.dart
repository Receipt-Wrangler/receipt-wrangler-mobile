import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/form_state.dart';
import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../utils/forms.dart';
import '../functions/permissions.dart';

class ReceiptEditPopupMenu extends StatelessWidget {
  const ReceiptEditPopupMenu(
      {super.key, required this.groupId, required this.popupMenuChildren});

  final int groupId;

  final List<PopupMenuEntry> popupMenuChildren;

  @override
  Widget build(BuildContext context) {
    late final authModel = Provider.of<AuthModel>(context, listen: false);
    late final groupModel = Provider.of<GroupModel>(context, listen: false);
    late final formState = getFormStateFromContext(context);
    var canEdit = false;

    if (formState == WranglerFormState.add) {
      canEdit = true;
    }

    if (formState == WranglerFormState.edit) {
      canEdit = canEditReceipt(authModel, groupModel, groupId);
    }

    if (formState != WranglerFormState.view) {
      if (canEdit) {
        return PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return popupMenuChildren;
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return const SizedBox.shrink();
  }
}
