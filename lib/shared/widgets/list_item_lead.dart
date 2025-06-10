import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/constants/theme.dart';

import 'date_block.dart';

class ListItemLead extends StatefulWidget {
  const ListItemLead({
    super.key,
    required this.date,
    required this.color,
  });
  final Color color;

  final String date;

  @override
  State<ListItemLead> createState() => _ListItemLead();
}

class _ListItemLead extends State<ListItemLead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        border: Border.all(
          color: widget.color,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateBlock(date: widget.date),
        ],
      ),
    );
  }
}
