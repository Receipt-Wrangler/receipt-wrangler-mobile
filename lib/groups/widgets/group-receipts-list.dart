import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/groups/widgets/receipt-list-item.dart';
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
      var command = model.receiptPagedRequestCommand;
      command.page = pageKey;
      model.setReceiptPagedRequestCommand(command, false);

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

  @override
  Widget build(BuildContext context) {
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
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
