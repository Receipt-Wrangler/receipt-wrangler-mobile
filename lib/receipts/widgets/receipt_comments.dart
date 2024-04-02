import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;

import '../../models/receipt_model.dart';
import '../../models/user_model.dart';
import '../../shared/widgets/user_avatar.dart';

class ReceiptComments extends StatefulWidget {
  const ReceiptComments({super.key});

  @override
  State<ReceiptComments> createState() => _ReceiptComments();
}

class _ReceiptComments extends State<ReceiptComments> {
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;

  Widget buildWidgetList() {
    return ListView.builder(
      itemCount: receipt.comments.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildCommentRow(receipt.comments[index]),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Widget buildCommentRow(api.Comment comment) {
    var user = Provider.of<UserModel>(context, listen: false)
        .getUserById(comment.userId.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(
          userId: user?.id.toString(),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user?.displayName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(comment.comment.trim()),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(receipt.comments);
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildWidgetList());
  }
}
