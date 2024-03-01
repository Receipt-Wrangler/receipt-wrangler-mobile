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
    return Text(widget.header, style: const TextStyle(fontSize: 24));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Row(children: [getHeaderText()]),
              )
            ],
          ),
          widget.child
        ],
      ),
    );
  }
}
