import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({
    super.key,
    required this.children,
    this.bottomNavigationBarWidget,
    this.appBarWidget,
    this.bodyPadding,
  });

  final List<Widget> children;

  final Widget? bottomNavigationBarWidget;

  final PreferredSizeWidget? appBarWidget;

  final EdgeInsets? bodyPadding;

  @override
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarWidget,
      bottomNavigationBar: widget.bottomNavigationBarWidget,
      body: Container(
          padding:
              widget.bodyPadding ?? const EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: widget.children[0]),
    );
  }
}
