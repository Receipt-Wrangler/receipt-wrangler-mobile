//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MagicFillCommand {
  /// Returns a new [MagicFillCommand] instance.
  MagicFillCommand({
    this.imageData = const [],
    required this.filename,
  });

  /// Image data
  List<int> imageData;

  /// Name of file
  String filename;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MagicFillCommand &&
    _deepEquality.equals(other.imageData, imageData) &&
    other.filename == filename;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (imageData.hashCode) +
    (filename.hashCode);

  @override
  String toString() => 'MagicFillCommand[imageData=$imageData, filename=$filename]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'imageData'] = this.imageData;
      json[r'filename'] = this.filename;
    return json;
  }

  /// Returns a new [MagicFillCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MagicFillCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MagicFillCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MagicFillCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MagicFillCommand(
        imageData: json[r'imageData'] is Iterable
            ? (json[r'imageData'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        filename: mapValueOfType<String>(json, r'filename')!,
      );
    }
    return null;
  }

  static List<MagicFillCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MagicFillCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MagicFillCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MagicFillCommand> mapFromJson(dynamic json) {
    final map = <String, MagicFillCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MagicFillCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MagicFillCommand-objects as value to a dart map
  static Map<String, List<MagicFillCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MagicFillCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MagicFillCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'imageData',
    'filename',
  };
}

