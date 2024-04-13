import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';

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
            buildCommentRow(receipt.comments[index], index),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Widget buildCommentRow(api.Comment comment, int index) {
    var lastCommentHasSameUser = false;
    var spacerWidget = SizedBox.shrink();
    var user = Provider.of<UserModel>(context, listen: false)
        .getUserById(comment.userId.toString());

    var isLoggedInUsersComment = user?.id ==
        Provider.of<AuthModel>(context, listen: false).claims?.userId;

    if (index > 0 && receipt.comments[index - 1].userId == comment.userId) {
      lastCommentHasSameUser = true;
    }

    if (lastCommentHasSameUser && !isLoggedInUsersComment) {
      spacerWidget = SizedBox(width: 55);
    }

    return Row(
      mainAxisAlignment: isLoggedInUsersComment
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lastCommentHasSameUser || isLoggedInUsersComment
            ? spacerWidget
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: UserAvatar(
                      userId: user?.id.toString(),
                    ),
                  ),
                ),
              ),
        SizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isLoggedInUsersComment
                ? Theme.of(context).primaryColorLight
                : Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lastCommentHasSameUser
                  ? SizedBox.shrink()
                  : Text(user?.displayName ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold)),
              lastCommentHasSameUser ? SizedBox.shrink() : SizedBox(height: 5),
              Text(comment.comment.trim()),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommentWidgets(bool hasComments) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: hasComments
            ? buildWidgetList()
            : Center(child: Text("No comments found.")));
  }

  @override
  Widget build(BuildContext context) {
    var hasComments = receipt.comments.length > 0;
    if (hasComments) {
      return SingleChildScrollView(child: buildCommentWidgets(hasComments));
    } else {
      return buildCommentWidgets(hasComments);
    }
  }
}
