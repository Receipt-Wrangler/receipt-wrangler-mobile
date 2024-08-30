import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/groups/widgets/constants/text_styles.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_list.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

import '../../../client/client.dart';
import '../../../utils/receipts.dart';

class FilteredReceipts extends StatefulWidget {
  const FilteredReceipts({super.key, required api.Widget this.dashboardWidget});

  final api.Widget dashboardWidget;

  @override
  State<FilteredReceipts> createState() => _FilteredReceipts();
}

class _FilteredReceipts extends State<FilteredReceipts> {
  late final groupId = getGroupId(context);
  final PagingController<int, api.PagedDataDataInner> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 5);

  @override
  Widget build(BuildContext context) {
    // TODO: In search, add the number of results too
    // TODO: get filter working with dio
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dashboardWidget.name ?? "",
            style: dashboardWidgetNameStyle,
          ),
          ReceiptList(
              pagingController: _pagingController,
              getPagedReceiptFuture: (page) {
                return OpenApiClient.client.getReceiptApi().getReceiptsForGroup(
                    groupId: int.parse(groupId),
                    receiptPagedRequestCommand:
                        (api.ReceiptPagedRequestCommandBuilder()
                              ..page = page
                              ..pageSize = 10
                              ..orderBy = "date"
                              ..sortDirection = api.SortDirection.desc
                              ..filter = dashboardConfigurationToFilter(
                                  widget.dashboardWidget.configuration))
                            .build());
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
