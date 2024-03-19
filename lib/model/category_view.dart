//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CategoryView {
  /// Returns a new [CategoryView] instance.
  CategoryView({
    this.createdAt,
    this.createdBy,
    required this.id,
    required this.name,
    this.description,
    this.updatedAt,
    required this.numberOfReceipts,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? createdBy;

  int id;

  /// Name of the category
  String name;

  /// Description of the category
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  /// Number of receipts associated with this category
  int numberOfReceipts;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CategoryView &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.id == id &&
     other.name == name &&
     other.description == description &&
     other.updatedAt == updatedAt &&
     other.numberOfReceipts == numberOfReceipts;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (id.hashCode) +
    (name.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (numberOfReceipts.hashCode);

  @override
  String toString() => 'CategoryView[createdAt=$createdAt, createdBy=$createdBy, id=$id, name=$name, description=$description, updatedAt=$updatedAt, numberOfReceipts=$numberOfReceipts]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
    if (this.createdBy != null) {
      json[r'createdBy'] = this.createdBy;
    } else {
      json[r'createdBy'] = null;
    }
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
      json[r'numberOfReceipts'] = this.numberOfReceipts;
    return json;
  }

  /// Returns a new [CategoryView] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CategoryView? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CategoryView[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CategoryView[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CategoryView(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description'),
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        numberOfReceipts: mapValueOfType<int>(json, r'numberOfReceipts')!,
      );
    }
    return null;
  }

  static List<CategoryView>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CategoryView>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CategoryView.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CategoryView> mapFromJson(dynamic json) {
    final map = <String, CategoryView>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CategoryView.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CategoryView-objects as value to a dart map
  static Map<String, List<CategoryView>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CategoryView>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CategoryView.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'numberOfReceipts',
  };
}

