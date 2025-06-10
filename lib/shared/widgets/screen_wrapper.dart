import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/constants/colors.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({
    super.key,
    required this.child,
    this.bottomNavigationBarWidget,
    this.appBarWidget,
    this.bodyPadding,
    this.bottomSheetWidget,
  });

  final Widget child;
  final Widget? bottomNavigationBarWidget;
  final PreferredSizeWidget? appBarWidget;
  final EdgeInsets? bodyPadding;
  final Widget? bottomSheetWidget;

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
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: widget.appBarWidget,
        bottomSheet: widget.bottomSheetWidget,
        bottomNavigationBar: widget.bottomNavigationBarWidget,
        backgroundColor: backgroundColor,
        body: Container(
          padding: widget.bodyPadding ?? screenPadding,
          width: MediaQuery.of(context).size.width,
          child: widget.child,
        ),
      ),
    );
  }
}
