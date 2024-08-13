import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

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
        var group = groupModel.getGroupById(searchResult.groupId.toString());
        var formattedDate =
            formatDate("MMM d, yyyy", DateTime.parse(searchResult.date));

        var title = "${formattedDate} - ${searchResult.name} (${group?.name})";
        return ListTile(
          title: Text(title),
          onTap: () {
            context.go('/receipts/${searchResult.id}/view');
          },
        );
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
