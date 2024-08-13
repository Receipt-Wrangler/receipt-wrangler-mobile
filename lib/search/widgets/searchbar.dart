import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../api.dart' as api;
import '../../models/search_model.dart';

class WranglerSearchBar extends StatefulWidget {
  const WranglerSearchBar({super.key});

  @override
  State<WranglerSearchBar> createState() => _WranglerSearchBar();
}

class _WranglerSearchBar extends State<WranglerSearchBar> {
  late final searchModel = Provider.of<SearchModel>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: FormBuilderTextField(
        name: "search",
        decoration: InputDecoration(label: Text("Search")),
        onChanged: (value) {
          var searchText = value ?? "";
          searchModel.searchTermBehaviorSubject.add(searchText);
          api.SearchApi().receiptSearch(searchText).then((value) {
            searchModel.setSearchResults(value ?? []);
          });
        },
      ),
    );
  }
}
