import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../functions/permissions.dart';

class ReceiptEditPopupMenu extends StatefulWidget {
  const ReceiptEditPopupMenu(
      {super.key, required this.groupId, required this.popupMenuChildren});

  final int groupId;

  final List<PopupMenuEntry> popupMenuChildren;

  @override
  _ReceiptEditPopupMenuState createState() {
    return _ReceiptEditPopupMenuState();
  }
}

class _ReceiptEditPopupMenuState extends State<ReceiptEditPopupMenu> {
  late final authModel = Provider.of<AuthModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var canEdit = canEditReceipt(authModel, groupModel, widget.groupId);
    if (canEdit) {
      return PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return widget.popupMenuChildren;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
