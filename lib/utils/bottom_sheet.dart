import 'package:flutter/material.dart';

showFullscreenBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height,
      minWidth: MediaQuery.of(context).size.width,
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: child,
      );
    },
  );
}
