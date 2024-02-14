import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;

class ReceiptListItem extends StatefulWidget {
  const ReceiptListItem({super.key, required this.data});

  final api.PagedDataDataInner data;

  @override
  State<ReceiptListItem> createState() => _ReceiptListItem();
}

class _ReceiptListItem extends State<ReceiptListItem> {
  Widget getStatusText() {
    switch (widget.data.status) {
      case api.ReceiptStatus.DRAFT:
        return const Text("Draft", style: TextStyle(color: Colors.grey));
      case api.ReceiptStatus.NEEDS_ATTENTION:
        return const Text("Needs Attention",
            style: TextStyle(color: Colors.red));
      case api.ReceiptStatus.OPEN:
        return const Text("Open");
      case api.ReceiptStatus.RESOLVED:
        return const Text("Resolved",
            style: TextStyle(color: Color.fromRGBO(144, 238, 144, 1)));
      default:
        throw Exception("Unknown status: ${widget.data.status}");
    }
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
            color: Colors.red,
          ),
          const SizedBox(width: 10),
          getDateText(),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data.name),
      subtitle: Text(widget.data.date),
      leading: getLeadingWidget(),
      trailing: getStatusText(),
      contentPadding: EdgeInsets.zero,
    );
  }
}
