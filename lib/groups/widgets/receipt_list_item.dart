import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/date_block.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_edit_button.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_widget.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../shared/functions/permissions.dart';

class ReceiptListItem extends StatefulWidget {
  const ReceiptListItem(
      {super.key, required this.receipt, this.displayGroup = false});

  final api.Receipt receipt;

  final bool displayGroup;

  @override
  State<ReceiptListItem> createState() => _ReceiptListItem();
}

class _ReceiptListItem extends State<ReceiptListItem> {
  late final authModel = Provider.of<AuthModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);

  Widget getStatusText() {
    var text = "";

    switch (widget.receipt.status) {
      case api.ReceiptStatus.DRAFT:
        text = "Draft";
      case api.ReceiptStatus.NEEDS_ATTENTION:
        text = "Needs Attention";
      case api.ReceiptStatus.OPEN:
        text = "Open";
      case api.ReceiptStatus.RESOLVED:
        text = "Resolved";
      default:
        throw Exception("Unknown status: ${widget.receipt.status}");
    }

    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [backgroundColor, getStatusColor()],
      )),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center, children: [Text(text)]),
    );
  }

  Widget getLeadingWidget() {
    return SizedBox(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 50,
            color: getStatusColor(),
          ),
          const SizedBox(width: 10),
          DateBlock(date: widget.receipt.createdAt ?? ""),
        ],
      ),
    );
  }

  Color getStatusColor() {
    switch (widget.receipt.status) {
      case api.ReceiptStatus.DRAFT:
        return const Color.fromRGBO(224, 224, 224, 1);
      case api.ReceiptStatus.NEEDS_ATTENTION:
        return const Color.fromRGBO(242, 191, 191, 1);
      case api.ReceiptStatus.OPEN:
        return const Color.fromRGBO(255, 250, 205, 1);
      case api.ReceiptStatus.RESOLVED:
        return const Color.fromRGBO(144, 238, 144, 1);
      default:
        throw Exception("Unknown status: ${widget.receipt.status}");
    }
  }

  Widget getSubtitleText() {
    var userNotFoundText = "User not found!";
    var userModel = Provider.of<UserModel>(context, listen: false);

    var user = userModel.getUserById(widget.receipt.paidByUserId.toString());
    var formattedAmount = formatCurrency(context, widget.receipt.amount);
    var formattedDate =
        formatDate(defaultDateFormat, DateTime.parse(widget.receipt.date));

    return Text(
        "${formattedAmount} paid by ${user?.displayName ?? userNotFoundText} on ${formattedDate}");
  }

  Widget buildListTile() {
    var titleText = widget.receipt.name;

    if (widget.displayGroup) {
      var group = groupModel.getGroupById(widget.receipt.groupId.toString());
      titleText = "${widget.receipt.name}\n(${group?.name})";
    }

    return ListTile(
        title: Text(
          titleText,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: getSubtitleText(),
        leading: getLeadingWidget(),
        trailing: getStatusText(),
        onTap: () => navigateToReceipt(WranglerFormState.view));
  }

  Widget buildEditButton() {
    return SlidableEditButton(
        onPressed: () => navigateToReceipt(WranglerFormState.edit));
  }

  void navigateToReceipt(WranglerFormState formState) {
    context.go("/receipts/${widget.receipt.id}/${formState.name}");
  }

  @override
  Widget build(BuildContext context) {
    var canEdit = canEditReceipt(authModel, groupModel, widget.receipt.groupId);

    return SlidableWidget(
        slideEnabled: canEdit,
        endActionPaneChildren: [buildEditButton()],
        slidableChild: buildListTile());
  }
}
