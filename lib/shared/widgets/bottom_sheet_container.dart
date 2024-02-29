import 'package:flutter/material.dart';

class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer(
      {super.key, required this.child, required this.header});

  final Widget child;

  final String header;

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainer();
}

class _BottomSheetContainer extends State<BottomSheetContainer> {
  Widget getHeaderText() {
    return Text(widget.header,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: widget.child);
  }
}
