import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key, required this.children});

  final List<Widget> children;

  @override
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.children,
        ),
      ),
    );
  }
}
