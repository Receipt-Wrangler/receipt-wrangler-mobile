import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart' as api;

class PagedDataList extends StatefulWidget {
  const PagedDataList(
      {super.key,
      required PagingController<int, api.PagedDataDataInner>
          this.pagingController,
      required Future<Response<api.PagedData>> Function(int)
          this.getPagedDataFuture,
      required Widget Function(BuildContext, api.PagedDataDataInner, int)
          this.listItemBuilder,
      required this.noItemsFoundText});

  final PagingController<int, api.PagedDataDataInner> pagingController;

  final Future<Response<api.PagedData>> Function(int) getPagedDataFuture;

  final Widget Function(BuildContext, api.PagedDataDataInner, int)
      listItemBuilder;

  final String noItemsFoundText;

  @override
  _PagedDataListState createState() {
    return _PagedDataListState();
  }
}

class _PagedDataListState extends State<PagedDataList> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final pagedData = await widget.getPagedDataFuture(pageKey);

      if (pagedData.data != null) {
        var length = widget.pagingController.itemList?.length ?? 0;
        var newData =
            pagedData.data?.data ?? BuiltList<api.PagedDataDataInner>([]);

        if (length == (pagedData.data?.totalCount ?? 0)) {
          widget.pagingController.appendLastPage(newData.toList());
        } else {
          widget.pagingController.appendPage(newData.toList(), pageKey + 1);
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
                return widget.listItemBuilder(context, item, index);
              },
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text(widget.noItemsFoundText),
              ),
            )));
  }
}
