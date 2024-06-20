import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FilterMultiSelect<T> extends StatefulWidget {
  const FilterMultiSelect({
    super.key,
    this.initialSelectedOptions,
    required this.options,
    required this.itemDisplayName,
  });

  final List<T>? initialSelectedOptions;

  final List<T> options;

  final String Function(T) itemDisplayName;

  @override
  FilterMultiSelectState<T> createState() {
    return FilterMultiSelectState();
  }
}

class FilterMultiSelectState<T> extends State<FilterMultiSelect<T>> {
  late List<T> filteredOptions = [...widget.options];
  List<T> selectedOptions = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialSelectedOptions != null) {
      widget.initialSelectedOptions!.forEach((element) {
        selectedOptions.add(element);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildFilterBar() {
      return Text("placeholder");
    }

    Widget buildChoiceChip(T option, int index) {
      return ChoiceChip(
        label: Text(widget.itemDisplayName(option)),
        selected: selectedOptions.contains(option),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selectedOptions.add(option);
            } else {
              selectedOptions.remove(option);
            }
          });
        },
      );
    }

    Widget buildChoiceChipGrid() {
      return MasonryGridView.count(
        shrinkWrap: true,
        itemCount: filteredOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return buildChoiceChip(widget.options[index], index);
        },
        crossAxisCount: 3,
      );
    }

    return Column(
      children: [
        buildFilterBar(),
        buildChoiceChipGrid(),
      ],
    );
  }
}
