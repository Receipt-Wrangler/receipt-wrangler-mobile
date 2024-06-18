import 'package:flutter/material.dart';

import '../../utils/bottom_sheet.dart';

showMultiselectBottomSheet(context) {
  showFullscreenBottomSheet(context, Text("hello"), "Quick Scan",
      actions: [], bodyPadding: EdgeInsets.zero);
}
