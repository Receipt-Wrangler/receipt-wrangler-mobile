import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_sheet_container.dart';

showFullscreenBottomSheet(BuildContext context, Widget child, String label) {
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
      return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BottomSheetContainer(
            header: label,
            child: child,
          ));
    },
  );
}
