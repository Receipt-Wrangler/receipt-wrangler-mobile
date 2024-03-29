import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';

showFullscreenBottomSheet(BuildContext context, Widget child, String label,
    {List<Widget>? actions,
    Widget? bottomSheetWidget,
    EdgeInsets? bodyPadding}) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    useSafeArea: true,
    isScrollControlled: true,
    showDragHandle: true,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height,
      minWidth: MediaQuery.of(context).size.width,
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder:
          (BuildContext context, void Function(void Function()) setState) {
        return ScreenWrapper(
            bodyPadding: bodyPadding,
            appBarWidget: TopAppBar(
              titleText: 'Quick Scan',
              actions: actions,
              hideAvatar: true,
              surfaceTintColor: Colors.white,
            ),
            bottomSheetWidget: bottomSheetWidget,
            child: SingleChildScrollView(
              child: child,
            ));
      });
    },
  );
}
