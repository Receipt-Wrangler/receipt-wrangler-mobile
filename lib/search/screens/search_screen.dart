import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/receipt_list_item.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';

import '../../api.dart' as api;
import '../../models/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late final searchModel = Provider.of<SearchModel>(context);
  late final groupModel = Provider.of<GroupModel>(context);

  Widget buildSearchTextText(String searchText) {
    return Text(searchText);
  }

  Widget buildReceiptList(List<api.SearchResult> searchResults) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var searchResult = searchResults[index];

        return ReceiptListItem(
            data: new api.PagedDataDataInner(
          amount: searchResult.amount ?? "",
          date: searchResult.date ?? "",
          groupId: searchResult.groupId ?? 0,
          id: searchResult.id ?? 0,
          name: searchResult.name ?? "",
          paidByUserId: searchResult.paidByUserId ?? 0,
          status: searchResult.receiptStatus ?? api.ReceiptStatus.DRAFT,
          createdAt: searchResult.createdAt ?? "",
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, SearchModel searchModel, child) {
      return buildReceiptList(searchModel.searchResults);
    });
  }
}
