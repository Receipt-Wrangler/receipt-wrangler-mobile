//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FileDataView {
  /// Returns a new [FileDataView] instance.
  FileDataView({
    required this.id,
    required this.createdAt,
    this.createdBy = 0,
    this.createdByString = '',
    this.updatedAt = '',
    required this.encodedImage,
    required this.name,
  });

  int id;

  String createdAt;

  int createdBy;

  /// Created by entity's name
  String createdByString;

  String updatedAt;

  /// Base64 encoded image
  String encodedImage;

  /// File name
  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileDataView &&
    other.id == id &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.createdByString == createdByString &&
    other.updatedAt == updatedAt &&
    other.encodedImage == encodedImage &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (createdAt.hashCode) +
    (createdBy.hashCode) +
    (createdByString.hashCode) +
    (updatedAt.hashCode) +
    (encodedImage.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'FileDataView[id=$id, createdAt=$createdAt, createdBy=$createdBy, createdByString=$createdByString, updatedAt=$updatedAt, encodedImage=$encodedImage, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'createdAt'] = this.createdAt;
      json[r'createdBy'] = this.createdBy;
      json[r'createdByString'] = this.createdByString;
      json[r'updatedAt'] = this.updatedAt;
      json[r'encodedImage'] = this.encodedImage;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [FileDataView] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileDataView? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FileDataView[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FileDataView[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FileDataView(
        id: mapValueOfType<int>(json, r'id')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        encodedImage: mapValueOfType<String>(json, r'encodedImage')!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<FileDataView> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileDataView>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileDataView.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileDataView> mapFromJson(dynamic json) {
    final map = <String, FileDataView>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileDataView.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileDataView-objects as value to a dart map
  static Map<String, List<FileDataView>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileDataView>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileDataView.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'createdAt',
    'encodedImage',
    'name',
  };
}

