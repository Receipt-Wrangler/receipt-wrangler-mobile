import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultiSelectField<T> extends StatefulWidget {
  const MultiSelectField({
    super.key,
    required this.name,
    required this.label,
    required this.itemDisplayName,
    required this.itemName,
    this.initialValue,
    this.onTap,
  });

  final String name;

  final String label;

  final String Function(T) itemDisplayName;

  final String itemName;

  final List<T>? initialValue;

  final Function()? onTap;

  @override
  State<MultiSelectField> createState() => _MultiSelectField<T>();
}

class _MultiSelectField<T> extends State<MultiSelectField<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<T>>(
      name: widget.name,
      initialValue: widget!.initialValue as dynamic,
      builder: (FormFieldState<List<T>?> field) {
        Widget buildChipLabel(T thing) {
          return Text(widget.itemDisplayName(thing));
        }

        Widget buildChip(T thing) {
          return ChoiceChip(
            label: buildChipLabel(thing),
            selectedColor: Theme.of(context).primaryColor,
            showCheckmark: false,
            selected: true,
            onSelected: (bool selected) {
              if (widget.onTap != null) {
                widget!.onTap!();
              }
            },
          );
        }

        List<Widget> buildChipList() {
          if (field.value != null && field.value!.isNotEmpty) {
            return (field.value as List<T>)
                .map((thing) => buildChip(thing))
                .toList();
          } else {
            return [Text("No ${widget.itemName} selected")];
          }
        }

        return InputDecorator(
          decoration: InputDecoration(labelText: widget.label),
          child: GestureDetector(
              child: Wrap(
                children: buildChipList(),
              ),
              onTap: () {
                if (widget.onTap != null) {
                  widget!.onTap!();
                }
              }),
        );
      },
    );
  }
}
