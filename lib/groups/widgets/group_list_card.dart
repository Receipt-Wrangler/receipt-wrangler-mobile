import 'package:flutter/material.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;

class GroupListCard extends StatefulWidget {
  const GroupListCard({super.key, required this.group});

  final api.Group group;

  @override
  State<GroupListCard> createState() => _GroupListCard();
}

class _GroupListCard extends State<GroupListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Text(
        widget.group.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
