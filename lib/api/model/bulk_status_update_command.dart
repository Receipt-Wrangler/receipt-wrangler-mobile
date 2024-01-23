//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BulkStatusUpdateCommand {
  /// Returns a new [BulkStatusUpdateCommand] instance.
  BulkStatusUpdateCommand({
    this.comment,
    required this.status,
    this.receiptIds = const [],
  });

  /// Optional comment to leave on each receipt
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? comment;

  /// Status to update to
  String status;

  /// Receipt ids to update
  List<int> receiptIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BulkStatusUpdateCommand &&
    other.comment == comment &&
    other.status == status &&
    _deepEquality.equals(other.receiptIds, receiptIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (comment == null ? 0 : comment!.hashCode) +
    (status.hashCode) +
    (receiptIds.hashCode);

  @override
  String toString() => 'BulkStatusUpdateCommand[comment=$comment, status=$status, receiptIds=$receiptIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
      json[r'status'] = this.status;
      json[r'receiptIds'] = this.receiptIds;
    return json;
  }

  /// Returns a new [BulkStatusUpdateCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BulkStatusUpdateCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BulkStatusUpdateCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BulkStatusUpdateCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BulkStatusUpdateCommand(
        comment: mapValueOfType<String>(json, r'comment'),
        status: mapValueOfType<String>(json, r'status')!,
        receiptIds: json[r'receiptIds'] is Iterable
            ? (json[r'receiptIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<BulkStatusUpdateCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BulkStatusUpdateCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BulkStatusUpdateCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BulkStatusUpdateCommand> mapFromJson(dynamic json) {
    final map = <String, BulkStatusUpdateCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BulkStatusUpdateCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BulkStatusUpdateCommand-objects as value to a dart map
  static Map<String, List<BulkStatusUpdateCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BulkStatusUpdateCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BulkStatusUpdateCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'receiptIds',
  };
}

