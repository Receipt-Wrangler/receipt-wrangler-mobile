import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/constants/theme.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';

class ListItemTrailingStatus extends StatefulWidget {
  const ListItemTrailingStatus({
    super.key,
    required this.color,
    required this.text,
    this.height = 50,
  });

  final Color color;

  final String text;

  final double height;

  @override
  _ListItemTrailingStatusState createState() {
    return _ListItemTrailingStatusState();
  }
}

class _ListItemTrailingStatusState extends State<ListItemTrailingStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: space12,
        vertical: space8,
      ),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(borderRadiusLarge),
        border: Border.all(
          color: widget.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: widget.color.withValues(alpha: 0.8),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
