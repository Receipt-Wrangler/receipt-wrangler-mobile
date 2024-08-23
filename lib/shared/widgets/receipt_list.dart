import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;

import '../../groups/widgets/receipt_list_item.dart';

class ReceiptList extends StatefulWidget {
  const ReceiptList({
    super.key,
    required PagingController<int, api.PagedDataDataInner>
        this.pagingController,
    required Future<Response<api.PagedData>> Function(int)
        this.getPagedReceiptFuture,
  });

  final PagingController<int, api.PagedDataDataInner> pagingController;

  final Future<Response<api.PagedData>> Function(int) getPagedReceiptFuture;

  @override
  _ReceiptListState createState() {
    return _ReceiptListState();
  }
}

class _ReceiptListState extends State<ReceiptList> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final receipts = await widget.getPagedReceiptFuture(pageKey);

      if (receipts.data != null) {
        var length = widget.pagingController.itemList?.length ?? 0;
        var newReceipts =
            receipts.data?.data ?? BuiltList<api.PagedDataDataInner>([]);

        if (length == (receipts.data?.totalCount ?? 0)) {
          widget.pagingController.appendLastPage(newReceipts.toList());
        } else {
          widget.pagingController.appendPage(newReceipts.toList(), pageKey + 1);
        }
      }
    } catch (error) {
      print(error);
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PagedListView<int, api.PagedDataDataInner>(
            pagingController: widget.pagingController,
            builderDelegate: PagedChildBuilderDelegate<api.PagedDataDataInner>(
              itemBuilder: (context, item, index) {
                return ReceiptListItem(
                    receipt: item.anyOf.values[0] as api.Receipt);
              },
            )));
  }
}
