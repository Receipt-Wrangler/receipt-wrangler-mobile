import 'package:flutter/material.dart';

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
  _FilterMultiSelect<T> createState() {
    return _FilterMultiSelect();
  }
}

class _FilterMultiSelect<T> extends State<FilterMultiSelect<T>> {
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
      return GridView.builder(
        shrinkWrap: true,
        itemCount: widget.options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return buildChoiceChip(widget.options[index], index);
        },
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
