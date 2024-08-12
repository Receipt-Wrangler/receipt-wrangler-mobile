import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late final searchModel = Provider.of<SearchModel>(context);

  Widget buildSearchTextText(String searchText) {
    return Text(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        StreamBuilder(
            stream: searchModel.searchTermBehaviorSubject.stream,
            builder: (context, snapshot) {
              return buildSearchTextText(snapshot.data ?? "");
            }),
      ],
    ));
  }
}
