import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

import '../../../api.dart' as api;
import '../../../utils/receipts.dart';

class FilteredReceipts extends StatefulWidget {
  const FilteredReceipts({super.key, required api.Widget this.dashboardWidget});

  final api.Widget dashboardWidget;

  @override
  State<FilteredReceipts> createState() => _FilteredReceipts();
}

class _FilteredReceipts extends State<FilteredReceipts> {
  late final groupId = getGroupId(context);
  late final filteredDataFuture = api.ReceiptApi().getReceiptsForGroup(
      int.parse(groupId ?? "0"),
      api.ReceiptPagedRequestCommand(
          page: 1,
          pageSize: 10,
          orderBy: "date",
          sortDirection: api.SortDirection.desc,
          filter: dashboardConfigurationToFilter(
              widget.dashboardWidget.configuration)));

  @override
  Widget build(BuildContext context) {
    // TODO: Look into refactoring the infinite scroll widget to b more generic. We could use that here
    // TODO: In search, add the number of results too
    print(widget.dashboardWidget.configuration);
    return SizedBox(
        child: FutureBuilder(
      future: filteredDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Column(
          children: [Text(widget.dashboardWidget.name ?? "")],
        );
      },
    ));
  }
}
