import 'package:flutter/material.dart';

class ReceiptQuickActions extends StatefulWidget {
  const ReceiptQuickActions({super.key});

  @override
  State<ReceiptQuickActions> createState() => _ReceiptQuickActions();
}

class _ReceiptQuickActions extends State<ReceiptQuickActions> {
  var quickActions = ["Split Evenly", "Split Evenly with Portions"];
  var quickActionsSelection = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              children: [...quickActions.map((action) => Text(action))],
              isSelected: quickActionsSelection,
              onPressed: (selected) => setState(() {
                var newState = !quickActionsSelection[selected];

                quickActionsSelection = [false, false];
                quickActionsSelection[selected] = newState;
              }),
            )
          ],
        )
      ],
    );
  }
}
