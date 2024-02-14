import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';

class ReceiptListItem extends StatefulWidget {
  const ReceiptListItem({super.key, required this.data});

  final api.PagedDataDataInner data;

  @override
  State<ReceiptListItem> createState() => _ReceiptListItem();
}

class _ReceiptListItem extends State<ReceiptListItem> {
  Widget getStatusText() {
    var text = "";
    switch (widget.data.status) {
      case api.ReceiptStatus.DRAFT:
        text = "Draft";
      case api.ReceiptStatus.NEEDS_ATTENTION:
        text = "Needs Attention";
      case api.ReceiptStatus.OPEN:
        text = "Open";
      case api.ReceiptStatus.RESOLVED:
        text = "Resolved";
      default:
        throw Exception("Unknown status: ${widget.data.status}");
    }

    return Text(text, style: TextStyle(color: getStatusColor()));
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
          getDateText(),
        ],
      ),
    );
  }

  Color getStatusColor() {
    switch (widget.data.status) {
      case api.ReceiptStatus.DRAFT:
        return Colors.grey;
      case api.ReceiptStatus.NEEDS_ATTENTION:
        return Colors.red;
      case api.ReceiptStatus.OPEN:
        return Colors.blue;
      case api.ReceiptStatus.RESOLVED:
        return Color.fromRGBO(144, 238, 144, 1);
      default:
        throw Exception("Unknown status: ${widget.data.status}");
    }
  }

  Widget getDateText() {
    var date = DateTime.parse(widget.data.date);
    DateFormat format = DateFormat("MMM d");
    var formattedDate = format.format(date);
    var formattedDateParts = formattedDate.split(" ");

    var dateTextWidgets = formattedDateParts.map((e) {
      return Text(
        e,
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...dateTextWidgets],
    );
  }

  Widget getSubtitleText() {
    var userNotFoundText = "User not found!";
    var userModel = Provider.of<UserModel>(context, listen: false);

    var user = userModel.getUserById(widget.data.paidByUserId.toString());
    var amount = double.parse(widget.data.amount);
    var formattedAmount = formatCurrency(amount);

    return Text(
        "${formattedAmount} paid by ${user?.displayName ?? userNotFoundText}");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data.name),
      subtitle: getSubtitleText(),
      leading: getLeadingWidget(),
      trailing: getStatusText(),
      contentPadding: EdgeInsets.zero,
    );
  }
}
