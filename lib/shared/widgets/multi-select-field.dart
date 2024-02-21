import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MultiSelectField<T> extends FormBuilderField<List<T>> {
  MultiSelectField({
    required String name,
    required String label,
    required String Function(T) itemDisplayName,
    required String itemName,
    List<T>? initialValue,
  }) : super(
          key: Key(name),
          name: name,
          initialValue: initialValue ?? [],
          builder: (FormFieldState<List<T>?> field) {
            return InputDecorator(
              decoration: InputDecoration(labelText: label),
              child: GestureDetector(
                  child: Wrap(
                    children: (field.value != null && field.value!.isNotEmpty)
                        ? (field.value as List<T>)
                            .map((thing) => ChoiceChip(
                                  label: Text(itemDisplayName(thing)),
                                  selected: true,
                                ))
                            .toList()
                        : [Text("No $itemName selected")],
                  ),
                  onTap: () {}),
            );
          },
        );
}
