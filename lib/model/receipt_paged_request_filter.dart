//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReceiptPagedRequestFilter {
  /// Returns a new [ReceiptPagedRequestFilter] instance.
  ReceiptPagedRequestFilter({
    this.date,
    this.amount,
    this.name,
    this.paidBy,
    this.categories,
    this.tags,
    this.status,
    this.resolvedDate,
    this.createdAt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? date;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? amount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? paidBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? categories;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? tags;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? resolvedDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PagedRequestField? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReceiptPagedRequestFilter &&
     other.date == date &&
     other.amount == amount &&
     other.name == name &&
     other.paidBy == paidBy &&
     other.categories == categories &&
     other.tags == tags &&
     other.status == status &&
     other.resolvedDate == resolvedDate &&
     other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (date == null ? 0 : date!.hashCode) +
    (amount == null ? 0 : amount!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (paidBy == null ? 0 : paidBy!.hashCode) +
    (categories == null ? 0 : categories!.hashCode) +
    (tags == null ? 0 : tags!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (resolvedDate == null ? 0 : resolvedDate!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'ReceiptPagedRequestFilter[date=$date, amount=$amount, name=$name, paidBy=$paidBy, categories=$categories, tags=$tags, status=$status, resolvedDate=$resolvedDate, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.date != null) {
      json[r'date'] = this.date;
    } else {
      json[r'date'] = null;
    }
    if (this.amount != null) {
      json[r'amount'] = this.amount;
    } else {
      json[r'amount'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.paidBy != null) {
      json[r'paidBy'] = this.paidBy;
    } else {
      json[r'paidBy'] = null;
    }
    if (this.categories != null) {
      json[r'categories'] = this.categories;
    } else {
      json[r'categories'] = null;
    }
    if (this.tags != null) {
      json[r'tags'] = this.tags;
    } else {
      json[r'tags'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.resolvedDate != null) {
      json[r'resolvedDate'] = this.resolvedDate;
    } else {
      json[r'resolvedDate'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [ReceiptPagedRequestFilter] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReceiptPagedRequestFilter? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReceiptPagedRequestFilter[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReceiptPagedRequestFilter[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReceiptPagedRequestFilter(
        date: PagedRequestField.fromJson(json[r'date']),
        amount: PagedRequestField.fromJson(json[r'amount']),
        name: PagedRequestField.fromJson(json[r'name']),
        paidBy: PagedRequestField.fromJson(json[r'paidBy']),
        categories: PagedRequestField.fromJson(json[r'categories']),
        tags: PagedRequestField.fromJson(json[r'tags']),
        status: PagedRequestField.fromJson(json[r'status']),
        resolvedDate: PagedRequestField.fromJson(json[r'resolvedDate']),
        createdAt: PagedRequestField.fromJson(json[r'createdAt']),
      );
    }
    return null;
  }

  static List<ReceiptPagedRequestFilter>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReceiptPagedRequestFilter>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReceiptPagedRequestFilter.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReceiptPagedRequestFilter> mapFromJson(dynamic json) {
    final map = <String, ReceiptPagedRequestFilter>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceiptPagedRequestFilter.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReceiptPagedRequestFilter-objects as value to a dart map
  static Map<String, List<ReceiptPagedRequestFilter>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReceiptPagedRequestFilter>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceiptPagedRequestFilter.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

