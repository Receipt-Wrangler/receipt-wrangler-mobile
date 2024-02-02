import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper(
      {super.key,
      required this.children,
      this.bottomNavigationBarWidget,
      this.appBarWidget});

  final List<Widget> children;

  final Widget? bottomNavigationBarWidget;

  final PreferredSizeWidget? appBarWidget;

  @override
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarWidget,
      bottomNavigationBar: widget.bottomNavigationBarWidget,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
