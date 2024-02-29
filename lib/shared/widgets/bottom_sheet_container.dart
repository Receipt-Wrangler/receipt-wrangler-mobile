import 'package:flutter/material.dart';

class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer(
      {super.key, required this.child, required this.label});

  final Widget child;

  final String label;

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainer();
}

class _BottomSheetContainer extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [widget.child],
      ),
    );
  }
}
