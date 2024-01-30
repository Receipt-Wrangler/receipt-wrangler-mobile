//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReceiptPagedRequestCommand {
  /// Returns a new [ReceiptPagedRequestCommand] instance.
  ReceiptPagedRequestCommand({
    required this.page,
    required this.pageSize,
    this.orderBy,
    this.sortDirection,
    this.filter,
  });

  /// Page number
  int page;

  /// Number of records per page
  int pageSize;

  /// field to order on
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? orderBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SortDirection? sortDirection;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ReceiptPagedRequestFilter? filter;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReceiptPagedRequestCommand &&
    other.page == page &&
    other.pageSize == pageSize &&
    other.orderBy == orderBy &&
    other.sortDirection == sortDirection &&
    other.filter == filter;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (page.hashCode) +
    (pageSize.hashCode) +
    (orderBy == null ? 0 : orderBy!.hashCode) +
    (sortDirection == null ? 0 : sortDirection!.hashCode) +
    (filter == null ? 0 : filter!.hashCode);

  @override
  String toString() => 'ReceiptPagedRequestCommand[page=$page, pageSize=$pageSize, orderBy=$orderBy, sortDirection=$sortDirection, filter=$filter]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'page'] = this.page;
      json[r'pageSize'] = this.pageSize;
    if (this.orderBy != null) {
      json[r'orderBy'] = this.orderBy;
    } else {
      json[r'orderBy'] = null;
    }
    if (this.sortDirection != null) {
      json[r'sortDirection'] = this.sortDirection;
    } else {
      json[r'sortDirection'] = null;
    }
    if (this.filter != null) {
      json[r'filter'] = this.filter;
    } else {
      json[r'filter'] = null;
    }
    return json;
  }

  /// Returns a new [ReceiptPagedRequestCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReceiptPagedRequestCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReceiptPagedRequestCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReceiptPagedRequestCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReceiptPagedRequestCommand(
        page: mapValueOfType<int>(json, r'page')!,
        pageSize: mapValueOfType<int>(json, r'pageSize')!,
        orderBy: mapValueOfType<String>(json, r'orderBy'),
        sortDirection: SortDirection.fromJson(json[r'sortDirection']),
        filter: ReceiptPagedRequestFilter.fromJson(json[r'filter']),
      );
    }
    return null;
  }

  static List<ReceiptPagedRequestCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReceiptPagedRequestCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReceiptPagedRequestCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReceiptPagedRequestCommand> mapFromJson(dynamic json) {
    final map = <String, ReceiptPagedRequestCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceiptPagedRequestCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReceiptPagedRequestCommand-objects as value to a dart map
  static Map<String, List<ReceiptPagedRequestCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReceiptPagedRequestCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReceiptPagedRequestCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'page',
    'pageSize',
  };
}

