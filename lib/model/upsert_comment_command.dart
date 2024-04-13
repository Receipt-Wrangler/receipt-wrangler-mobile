//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertCommentCommand {
  /// Returns a new [UpsertCommentCommand] instance.
  UpsertCommentCommand({
    required this.comment,
    required this.receiptId,
    required this.userId,
  });

  /// Comment itself
  String comment;

  /// Receipt foreign key
  int receiptId;

  /// User foreign key
  int userId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertCommentCommand &&
     other.comment == comment &&
     other.receiptId == receiptId &&
     other.userId == userId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (comment.hashCode) +
    (receiptId.hashCode) +
    (userId.hashCode);

  @override
  String toString() => 'UpsertCommentCommand[comment=$comment, receiptId=$receiptId, userId=$userId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'comment'] = this.comment;
      json[r'receiptId'] = this.receiptId;
      json[r'userId'] = this.userId;
    return json;
  }

  /// Returns a new [UpsertCommentCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertCommentCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertCommentCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertCommentCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertCommentCommand(
        comment: mapValueOfType<String>(json, r'comment')!,
        receiptId: mapValueOfType<int>(json, r'receiptId')!,
        userId: mapValueOfType<int>(json, r'userId')!,
      );
    }
    return null;
  }

  static List<UpsertCommentCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertCommentCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertCommentCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertCommentCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertCommentCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertCommentCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertCommentCommand-objects as value to a dart map
  static Map<String, List<UpsertCommentCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertCommentCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertCommentCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'comment',
    'receiptId',
    'userId',
  };
}

