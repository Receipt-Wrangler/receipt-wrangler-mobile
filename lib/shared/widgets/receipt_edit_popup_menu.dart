import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/auth_model.dart';
import '../../models/group_model.dart';
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

    var canEdit = canEditReceipt(authModel, groupModel, groupId);
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
}

class ReceiptEditPopupMenuState {}
