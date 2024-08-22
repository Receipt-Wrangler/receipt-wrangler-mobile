import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/receipts.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/receipt_list_item.dart';
import 'package:receipt_wrangler_mobile/models/receipt-list-model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/receipt_list.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsList extends StatefulWidget {
  const GroupReceiptsList({super.key});

  @override
  State<GroupReceiptsList> createState() => _GroupReceiptsList();
}

class _GroupReceiptsList extends State<GroupReceiptsList> {
  final PagingController<int, api.PagedDataDataInner> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 5);

  Widget buildSortFilterBar() {
    return Row(
      children: [
        buildSortChip(),
        SizedBox(
          width: 4,
        ),
        buildSortDirectionChip()
      ],
    );
  }

  Widget buildSortDirectionChip() {
    var direction =
        Provider.of<ReceiptListModel>(context, listen: false).sortDirection;
    return PopupMenuButton(
      child: Chip(
        label: Text(
            direction == api.SortDirection.asc ? "Ascending" : "Descending"),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("Sort Ascending"),
            value: api.SortDirection.asc,
          ),
          PopupMenuItem(
            child: Text("Sort Descending"),
            value: api.SortDirection.desc,
          ),
        ];
      },
      onSelected: (value) {
        var model = Provider.of<ReceiptListModel>(context, listen: false);
        model.setSortDirection(value, false);
        _pagingController.refresh();
      },
    );
  }

  Widget buildSortChip() {
    return PopupMenuButton(
      child: Chip(
        label: Text(getSortChipText()),
      ),
      itemBuilder: (context) => receiptSortOptions.map((option) {
        return PopupMenuItem(
          child: Text("Sort by ${option.displayLabel}"),
          value: option.columnName,
        );
      }).toList(),
      onSelected: (value) {
        var model = Provider.of<ReceiptListModel>(context, listen: false);
        model.setOrderBy(value, false);
        _pagingController.refresh();
      },
    );
  }

  String getSortChipText() {
    var model = Provider.of<ReceiptListModel>(context, listen: false);
    var orderBy = model.orderBy;

    var option = receiptSortOptions.firstWhere(
      (element) => element.columnName == orderBy,
      orElse: () => receiptSortOptions.first,
    );

    return option.displayLabel;
  }

  Widget buildReceiptList() {
    return Expanded(
        child: PagedListView<int, api.PagedDataDataInner>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<api.PagedDataDataInner>(
              itemBuilder: (context, item, index) {
                var receipt = item.oneOf.value as api.Receipt;
                return ReceiptListItem(receipt: receipt);
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSortFilterBar(),
        ReceiptList(
          pagingController: _pagingController,
          getPagedReceiptFuture: (pageKey) {
            var model = Provider.of<ReceiptListModel>(context, listen: false);
            model.setPage(pageKey, false);
            var command = model.receiptPagedRequestCommand;

            return api.Openapi().getReceiptApi().getReceiptsForGroup(
                  groupId: int.parse(getGroupId(context)),
                  receiptPagedRequestCommand: command,
                );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
