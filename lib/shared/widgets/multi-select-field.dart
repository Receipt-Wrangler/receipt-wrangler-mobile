import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultiSelectField<T> extends FormBuilderField<List<T>> {
  MultiSelectField({
    required String name,
    required String label,
    required String Function(T) itemDisplayName,
    required String itemName,
    List<T>? initialValue,
    Function()? onTap,
  }) : super(
          key: Key(name),
          name: name,
          initialValue: initialValue ?? [],
          builder: (FormFieldState<List<T>?> field) {
            Widget buildChip(T thing) {
              return ChoiceChip(
                label: Text(itemDisplayName(thing)),
                selectedColor: Colors.blue,
                selected: true,
              );
            }

            List<Widget> buildChipList() {
              if (field.value != null && field.value!.isNotEmpty) {
                return (field.value as List<T>)
                    .map((thing) => buildChip(thing))
                    .toList();
              } else {
                return [Text("No $itemName selected")];
              }
            }

            return InputDecorator(
              decoration: InputDecoration(labelText: label),
              child: GestureDetector(
                  child: Wrap(
                    children: buildChipList(),
                  ),
                  onTap: () {
                    if (onTap != null) {
                      onTap();
                    }
                  }),
            );
          },
        );
}
