//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PagedRequestFieldValue {
  /// Returns a new [PagedRequestFieldValue] instance.
  PagedRequestFieldValue();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PagedRequestFieldValue && false;

  @override
  int get hashCode => 0;

  // ignore: unnecessary_parenthesis

  @override
  String toString() => 'PagedRequestFieldValue[]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }

  /// Returns a new [PagedRequestFieldValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PagedRequestFieldValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PagedRequestFieldValue[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PagedRequestFieldValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PagedRequestFieldValue();
    }
    return null;
  }

  static List<PagedRequestFieldValue>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PagedRequestFieldValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PagedRequestFieldValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PagedRequestFieldValue> mapFromJson(dynamic json) {
    final map = <String, PagedRequestFieldValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PagedRequestFieldValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PagedRequestFieldValue-objects as value to a dart map
  static Map<String, List<PagedRequestFieldValue>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PagedRequestFieldValue>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PagedRequestFieldValue.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
