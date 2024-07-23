import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/receipts.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/receipt_list_item.dart';
import 'package:receipt_wrangler_mobile/models/receipt-list-model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsList extends StatefulWidget {
  const GroupReceiptsList({super.key});

  @override
  State<GroupReceiptsList> createState() => _GroupReceiptsList();
}

class _GroupReceiptsList extends State<GroupReceiptsList> {
  final PagingController<int, api.PagedDataDataInner> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 5);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var model = Provider.of<ReceiptListModel>(context, listen: false);
      model.setPage(pageKey, false);
      var command = model.receiptPagedRequestCommand;

      var groupId = int.parse(getGroupId(context) ?? "");
      final receipts =
          await api.ReceiptApi().getReceiptsForGroup(groupId, command);

      if (receipts?.data != null) {
        var length = _pagingController.itemList?.length ?? 0;
        var newReceipts = receipts?.data ?? [];

        if (length == receipts?.totalCount) {
          _pagingController.appendLastPage(newReceipts);
        } else {
          _pagingController.appendPage(newReceipts, pageKey + 1);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

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
                return ReceiptListItem(data: item);
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSortFilterBar(),
        buildReceiptList(),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
