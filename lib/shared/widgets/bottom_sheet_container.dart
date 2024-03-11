import 'package:flutter/material.dart';

class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer(
      {super.key, required this.child, required this.header, this.actions});

  final Widget child;
  final String header;
  final List<Widget>? actions;

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          //
          automaticallyImplyLeading: false,
          // This is what makes the header sticky
          floating: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(16), // Adjust padding if needed
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      Text(widget.header, style: const TextStyle(fontSize: 24)),
                ),
                Row(children: [...widget.actions ?? []]),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: widget.child, // Your main content widget
        ),
      ],
    );
  }
}
