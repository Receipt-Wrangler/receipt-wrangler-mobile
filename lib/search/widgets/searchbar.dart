import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../client/client.dart';
import '../../constants/theme.dart';
import '../../constants/spacing.dart';
import '../../constants/colors.dart';
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
    return Container(
      margin: const EdgeInsets.all(space16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        boxShadow: cardShadow,
      ),
      child: FormBuilder(
        child: FormBuilderTextField(
          name: "search",
          decoration: InputDecoration(
            labelText: "Search receipts...",
            prefixIcon: const Icon(
              Icons.search,
              color: gray500,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: gray400,
              ),
              onPressed: () {
                // Clear search
                searchModel.searchTermBehaviorSubject.add("");
                searchModel.setSearchResults([]);
              },
            ),
            filled: true,
            fillColor: gray50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
              borderSide: const BorderSide(
                color: primaryBlue,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: space16,
              vertical: space12,
            ),
          ),
          onChanged: (value) {
            var searchText = value ?? "";
            searchModel.searchTermBehaviorSubject.add(searchText);
            OpenApiClient.client
                .getSearchApi()
                .receiptSearch(searchTerm: searchText)
                .then((value) {
              searchModel.setSearchResults(value.data?.toList() ?? []);
            });
          },
        ),
      ),
    );
  }
}
