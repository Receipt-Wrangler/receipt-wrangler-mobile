//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PagedRequestField {
  /// Returns a new [PagedRequestField] instance.
  PagedRequestField({
    required this.operation,
    required this.value,
  });

  /// Filter operation
  String operation;

  PagedRequestFieldValue value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PagedRequestField &&
    other.operation == operation &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (operation.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'PagedRequestField[operation=$operation, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'operation'] = this.operation;
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [PagedRequestField] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PagedRequestField? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PagedRequestField[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PagedRequestField[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PagedRequestField(
        operation: mapValueOfType<String>(json, r'operation')!,
        value: PagedRequestFieldValue.fromJson(json[r'value'])!,
      );
    }
    return null;
  }

  static List<PagedRequestField> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PagedRequestField>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PagedRequestField.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PagedRequestField> mapFromJson(dynamic json) {
    final map = <String, PagedRequestField>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PagedRequestField.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PagedRequestField-objects as value to a dart map
  static Map<String, List<PagedRequestField>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PagedRequestField>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PagedRequestField.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'operation',
    'value',
  };
}

