import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_wrangler_mobile/constants/colors.dart';

class DateBlock extends StatefulWidget {
  const DateBlock({
    super.key,
    required this.date,
  });

  final String date;

  @override
  State<DateBlock> createState() => _DateBlock();
}

class _DateBlock extends State<DateBlock> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(widget.date);
    DateFormat format = DateFormat("MMM d");
    var formattedDate = format.format(date);
    var formattedDateParts = formattedDate.split(" ");

    var dateTextWidgets = formattedDateParts.map((e) {
      return Text(
        e,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: gray800,
        ),
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...dateTextWidgets],
    );
  }
}
