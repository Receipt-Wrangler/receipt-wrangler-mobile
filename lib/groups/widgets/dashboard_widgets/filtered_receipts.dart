import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_list.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

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
        children: [
          Text(widget.dashboardWidget.name ?? ""),
          ReceiptList(
              pagingController: _pagingController,
              getPagedReceiptFuture: (page) {
                return api.Openapi().getReceiptApi().getReceiptsForGroup(
                    groupId: int.parse(groupId),
                    receiptPagedRequestCommand:
                        (api.ReceiptPagedRequestCommandBuilder()
                              ..page = page
                              ..pageSize = 10
                              ..orderBy = "date"
                              ..sortDirection = api.SortDirection.desc)
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
