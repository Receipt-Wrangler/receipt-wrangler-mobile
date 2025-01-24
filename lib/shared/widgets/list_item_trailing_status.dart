import 'package:flutter/material.dart';

class ListItemTrailingStatus extends StatefulWidget {
  const ListItemTrailingStatus({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;

  final String text;

  @override
  _ListItemTrailingStatusState createState() {
    return _ListItemTrailingStatusState();
  }
}

class _ListItemTrailingStatusState extends State<ListItemTrailingStatus> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [backgroundColor, widget.color],
      )),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.text)]),
    );
  }
}
