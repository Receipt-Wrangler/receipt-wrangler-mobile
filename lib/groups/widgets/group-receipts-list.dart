import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsList extends StatefulWidget {
  const GroupReceiptsList({super.key});

  @override
  State<GroupReceiptsList> createState() => _GroupReceiptsList();
}

class _GroupReceiptsList extends State<GroupReceiptsList> {
  final PagingController<int, api.PagedDataDataInner> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var groupId = int.parse(getGroupId(context) ?? "");
      var command = api.ReceiptPagedRequestCommand(
          page: 1,
          pageSize: 10,
          orderBy: "date",
          sortDirection: api.SortDirection.desc,
          filter: api.ReceiptPagedRequestFilter());
      final receipts =
          await api.ReceiptApi().getReceiptsForGroup(groupId, command);

      if (receipts?.data != null) {
        _pagingController.appendPage(receipts?.data ?? [], 0);
        print(receipts?.data);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    var groupId = getGroupId(context);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var group = groupModel.getGroupById(groupId ?? "");

    return Expanded(
        child: PagedListView<int, api.PagedDataDataInner>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<api.PagedDataDataInner>(
              itemBuilder: (context, item, index) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.date.toString()),
                );
              },
            )));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
