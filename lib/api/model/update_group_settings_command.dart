//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateGroupSettingsCommand {
  /// Returns a new [UpdateGroupSettingsCommand] instance.
  UpdateGroupSettingsCommand({
    this.emailIntegrationEnabled,
    required this.emailToRead,
    this.subjectLineRegexes = const [],
    this.emailWhiteList = const [],
    this.emailDefaultReceiptStatus,
    this.emailDefaultReceiptPaidById,
  });

  /// Whether email integration is enabled
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailIntegrationEnabled;

  /// Email to read
  String emailToRead;

  /// Subject line regexes
  List<SubjectLineRegex> subjectLineRegexes;

  /// Email white list
  List<GroupSettingsWhiteListEmail> emailWhiteList;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ReceiptStatus? emailDefaultReceiptStatus;

  /// User foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? emailDefaultReceiptPaidById;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateGroupSettingsCommand &&
    other.emailIntegrationEnabled == emailIntegrationEnabled &&
    other.emailToRead == emailToRead &&
    _deepEquality.equals(other.subjectLineRegexes, subjectLineRegexes) &&
    _deepEquality.equals(other.emailWhiteList, emailWhiteList) &&
    other.emailDefaultReceiptStatus == emailDefaultReceiptStatus &&
    other.emailDefaultReceiptPaidById == emailDefaultReceiptPaidById;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (emailIntegrationEnabled == null ? 0 : emailIntegrationEnabled!.hashCode) +
    (emailToRead.hashCode) +
    (subjectLineRegexes.hashCode) +
    (emailWhiteList.hashCode) +
    (emailDefaultReceiptStatus == null ? 0 : emailDefaultReceiptStatus!.hashCode) +
    (emailDefaultReceiptPaidById == null ? 0 : emailDefaultReceiptPaidById!.hashCode);

  @override
  String toString() => 'UpdateGroupSettingsCommand[emailIntegrationEnabled=$emailIntegrationEnabled, emailToRead=$emailToRead, subjectLineRegexes=$subjectLineRegexes, emailWhiteList=$emailWhiteList, emailDefaultReceiptStatus=$emailDefaultReceiptStatus, emailDefaultReceiptPaidById=$emailDefaultReceiptPaidById]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.emailIntegrationEnabled != null) {
      json[r'emailIntegrationEnabled'] = this.emailIntegrationEnabled;
    } else {
      json[r'emailIntegrationEnabled'] = null;
    }
      json[r'emailToRead'] = this.emailToRead;
      json[r'subjectLineRegexes'] = this.subjectLineRegexes;
      json[r'emailWhiteList'] = this.emailWhiteList;
    if (this.emailDefaultReceiptStatus != null) {
      json[r'emailDefaultReceiptStatus'] = this.emailDefaultReceiptStatus;
    } else {
      json[r'emailDefaultReceiptStatus'] = null;
    }
    if (this.emailDefaultReceiptPaidById != null) {
      json[r'emailDefaultReceiptPaidById'] = this.emailDefaultReceiptPaidById;
    } else {
      json[r'emailDefaultReceiptPaidById'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateGroupSettingsCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateGroupSettingsCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateGroupSettingsCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateGroupSettingsCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateGroupSettingsCommand(
        emailIntegrationEnabled: mapValueOfType<bool>(json, r'emailIntegrationEnabled'),
        emailToRead: mapValueOfType<String>(json, r'emailToRead')!,
        subjectLineRegexes: SubjectLineRegex.listFromJson(json[r'subjectLineRegexes']),
        emailWhiteList: GroupSettingsWhiteListEmail.listFromJson(json[r'emailWhiteList']),
        emailDefaultReceiptStatus: ReceiptStatus.fromJson(json[r'emailDefaultReceiptStatus']),
        emailDefaultReceiptPaidById: mapValueOfType<int>(json, r'emailDefaultReceiptPaidById'),
      );
    }
    return null;
  }

  static List<UpdateGroupSettingsCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateGroupSettingsCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateGroupSettingsCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateGroupSettingsCommand> mapFromJson(dynamic json) {
    final map = <String, UpdateGroupSettingsCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateGroupSettingsCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateGroupSettingsCommand-objects as value to a dart map
  static Map<String, List<UpdateGroupSettingsCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateGroupSettingsCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateGroupSettingsCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'emailToRead',
    'subjectLineRegexes',
    'emailWhiteList',
  };
}

