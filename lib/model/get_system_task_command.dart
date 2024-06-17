//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetSystemTaskCommand {
  /// Returns a new [GetSystemTaskCommand] instance.
  GetSystemTaskCommand({
    this.associatedEntityId,
    this.associatedEntityType,
    required this.page,
    required this.pageSize,
    this.orderBy,
    this.sortDirection,
  });

  /// Associated entity id
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? associatedEntityId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AssociatedEntityType? associatedEntityType;

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

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetSystemTaskCommand &&
     other.associatedEntityId == associatedEntityId &&
     other.associatedEntityType == associatedEntityType &&
     other.page == page &&
     other.pageSize == pageSize &&
     other.orderBy == orderBy &&
     other.sortDirection == sortDirection;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (associatedEntityId == null ? 0 : associatedEntityId!.hashCode) +
    (associatedEntityType == null ? 0 : associatedEntityType!.hashCode) +
    (page.hashCode) +
    (pageSize.hashCode) +
    (orderBy == null ? 0 : orderBy!.hashCode) +
    (sortDirection == null ? 0 : sortDirection!.hashCode);

  @override
  String toString() => 'GetSystemTaskCommand[associatedEntityId=$associatedEntityId, associatedEntityType=$associatedEntityType, page=$page, pageSize=$pageSize, orderBy=$orderBy, sortDirection=$sortDirection]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.associatedEntityId != null) {
      json[r'associatedEntityId'] = this.associatedEntityId;
    } else {
      json[r'associatedEntityId'] = null;
    }
    if (this.associatedEntityType != null) {
      json[r'associatedEntityType'] = this.associatedEntityType;
    } else {
      json[r'associatedEntityType'] = null;
    }
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
    return json;
  }

  /// Returns a new [GetSystemTaskCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetSystemTaskCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetSystemTaskCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetSystemTaskCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetSystemTaskCommand(
        associatedEntityId: mapValueOfType<int>(json, r'associatedEntityId'),
        associatedEntityType: AssociatedEntityType.fromJson(json[r'associatedEntityType']),
        page: mapValueOfType<int>(json, r'page')!,
        pageSize: mapValueOfType<int>(json, r'pageSize')!,
        orderBy: mapValueOfType<String>(json, r'orderBy'),
        sortDirection: SortDirection.fromJson(json[r'sortDirection']),
      );
    }
    return null;
  }

  static List<GetSystemTaskCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetSystemTaskCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetSystemTaskCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetSystemTaskCommand> mapFromJson(dynamic json) {
    final map = <String, GetSystemTaskCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetSystemTaskCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetSystemTaskCommand-objects as value to a dart map
  static Map<String, List<GetSystemTaskCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetSystemTaskCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetSystemTaskCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
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

