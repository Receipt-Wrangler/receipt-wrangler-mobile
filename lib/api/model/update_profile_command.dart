//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProfileCommand {
  /// Returns a new [UpdateProfileCommand] instance.
  UpdateProfileCommand({
    required this.displayName,
    required this.defaultAvatarColor,
  });

  /// User's displayName
  String displayName;

  /// Color of default avatar
  String defaultAvatarColor;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProfileCommand &&
    other.displayName == displayName &&
    other.defaultAvatarColor == defaultAvatarColor;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (displayName.hashCode) +
    (defaultAvatarColor.hashCode);

  @override
  String toString() => 'UpdateProfileCommand[displayName=$displayName, defaultAvatarColor=$defaultAvatarColor]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'displayName'] = this.displayName;
      json[r'defaultAvatarColor'] = this.defaultAvatarColor;
    return json;
  }

  /// Returns a new [UpdateProfileCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProfileCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProfileCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProfileCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProfileCommand(
        displayName: mapValueOfType<String>(json, r'displayName')!,
        defaultAvatarColor: mapValueOfType<String>(json, r'defaultAvatarColor')!,
      );
    }
    return null;
  }

  static List<UpdateProfileCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProfileCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProfileCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProfileCommand> mapFromJson(dynamic json) {
    final map = <String, UpdateProfileCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProfileCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProfileCommand-objects as value to a dart map
  static Map<String, List<UpdateProfileCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProfileCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProfileCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'displayName',
    'defaultAvatarColor',
  };
}

