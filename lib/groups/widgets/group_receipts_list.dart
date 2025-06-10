import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/constants/receipts.dart';
import 'package:receipt_wrangler_mobile/constants/colors.dart';
import 'package:receipt_wrangler_mobile/constants/theme.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/receipt_list_item.dart';
import 'package:receipt_wrangler_mobile/models/receipt-list-model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/paged_data_list.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

import '../../client/client.dart';

class GroupReceiptsList extends StatefulWidget {
  const GroupReceiptsList({super.key});

  @override
  State<GroupReceiptsList> createState() => _GroupReceiptsList();
}

class _GroupReceiptsList extends State<GroupReceiptsList> {
  final PagingController<int, api.PagedDataDataInner> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 5);

  Widget buildSortFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: space16,
        vertical: space12,
      ),
      color: backgroundColor,
      child: Row(
        children: [
          buildSortChip(),
          const SizedBox(width: space12),
          buildSortDirectionChip(),
        ],
      ),
    );
  }

  Widget buildSortDirectionChip() {
    var direction =
        Provider.of<ReceiptListModel>(context, listen: false).sortDirection;
    return PopupMenuButton(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: space16,
          vertical: space8,
        ),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          border: Border.all(color: gray300, width: 1),
          boxShadow: [
            BoxShadow(
              color: shadowLight,
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              direction == api.SortDirection.asc
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              size: 16,
              color: gray700,
            ),
            const SizedBox(width: space8),
            Text(
              direction == api.SortDirection.asc ? "Ascending" : "Descending",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: gray700,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.arrow_upward, size: 16),
                const SizedBox(width: space8),
                const Text("Sort Ascending"),
              ],
            ),
            value: api.SortDirection.asc,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.arrow_downward, size: 16),
                const SizedBox(width: space8),
                const Text("Sort Descending"),
              ],
            ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: space16,
          vertical: space8,
        ),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          border: Border.all(color: gray300, width: 1),
          boxShadow: [
            BoxShadow(
              color: shadowLight,
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sort,
              size: 16,
              color: gray700,
            ),
            const SizedBox(width: space8),
            Text(
              getSortChipText(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: gray700,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
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
                var receipt = item.anyOf.values[0] as api.Receipt;
                return ReceiptListItem(receipt: receipt);
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSortFilterBar(),
        PagedDataList(
          pagingController: _pagingController,
          noItemsFoundText: "No receipts found",
          listItemBuilder: (context, receipt, index) {
            return ReceiptListItem(
                receipt: receipt.anyOf.values[0] as api.Receipt);
          },
          getPagedDataFuture: (pageKey) {
            var model = Provider.of<ReceiptListModel>(context, listen: false);
            model.setPage(pageKey, false);
            var command = model.receiptPagedRequestCommand;

            return OpenApiClient.client.getReceiptApi().getReceiptsForGroup(
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
