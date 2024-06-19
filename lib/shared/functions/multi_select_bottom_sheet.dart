import 'package:flutter/material.dart';

import '../../utils/bottom_sheet.dart';
import '../widgets/filter_multiselect.dart';

showMultiselectBottomSheet(
    context,
    String label,
    List<dynamic> options,
    List<dynamic> initialSelectedOptions,
    String Function(dynamic) itemDisplayName) {
  showFullscreenBottomSheet(
      context,
      FilterMultiSelect<dynamic>(
        options: options,
        initialSelectedOptions: initialSelectedOptions,
        itemDisplayName: itemDisplayName,
      ),
      label,
      actions: [],
      bodyPadding: EdgeInsets.zero);
}
