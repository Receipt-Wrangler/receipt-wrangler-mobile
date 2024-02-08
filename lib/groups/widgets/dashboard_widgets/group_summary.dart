import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/user_model.dart';

class GroupSummary extends StatefulWidget {
  const GroupSummary({super.key});

  @override
  State<GroupSummary> createState() => _GroupSummary();
}

class _GroupSummary extends State<GroupSummary> {
  String _getUserOwesText(
      MapEntry<String, String> mapEntry, UserModel userModel) {
    var user = userModel.getUserById(mapEntry.key);
    var amount = double.parse(mapEntry.value);
    var formattedAmount =
        NumberFormat.currency(decimalDigits: 2, name: "\$").format(amount);

    if (mapEntry.value.contains("-") || mapEntry.value == "0") {
      return "You owe ${user!.displayName}: $formattedAmount";
    } else {
      return "${user!.displayName} owes you: $formattedAmount";
    }
  }

  List<Widget> buildSummaryLineWidgets(Map<String, String>? userData) {
    var nothingOwed = [const Text("Phew, you're all caught up!")];
    var widgets = <Widget>[];
    if (userData == null || userData.isEmpty) {
      return nothingOwed;
    }
    var userModel = Provider.of<UserModel>(context, listen: false);

    userData.entries.forEach((element) {
      widgets.add(Row(
        children: [
          Text(_getUserOwesText(element, userModel)),
        ],
      ));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var groupSummaryFuture = api.UserApi().getAmountOwedForUser(groupId: 1);

    return FutureBuilder(
        future: groupSummaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Group Summary",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ...buildSummaryLineWidgets(snapshot.data!),
              ],
            );
          }
          return CircularProgressIndicator();
        });
  }
}
