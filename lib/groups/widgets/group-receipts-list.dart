import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsList extends StatefulWidget {
  const GroupReceiptsList({super.key});

  @override
  State<GroupReceiptsList> createState() => _GroupReceiptsList();
}

class _GroupReceiptsList extends State<GroupReceiptsList> {
  @override
  Widget build(BuildContext context) {
    var groupId = getGroupId(context);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var group = groupModel.getGroupById(groupId ?? "");

    return Text("wow");
  }
}
