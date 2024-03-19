//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FileData {
  /// Returns a new [FileData] instance.
  FileData({
    this.createdAt,
    this.createdBy,
    this.fileType,
    required this.id,
    this.imageData = const [],
    this.name,
    required this.receiptId,
    this.size,
    this.updatedAt,
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

  /// MIME file type
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileType;

  int id;

  /// Image data
  List<int> imageData;

  /// File name
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// Receipt foreign key
  int receiptId;

  /// File size
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? size;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileData &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.fileType == fileType &&
     other.id == id &&
     other.imageData == imageData &&
     other.name == name &&
     other.receiptId == receiptId &&
     other.size == size &&
     other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (fileType == null ? 0 : fileType!.hashCode) +
    (id.hashCode) +
    (imageData.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (receiptId.hashCode) +
    (size == null ? 0 : size!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'FileData[createdAt=$createdAt, createdBy=$createdBy, fileType=$fileType, id=$id, imageData=$imageData, name=$name, receiptId=$receiptId, size=$size, updatedAt=$updatedAt]';

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
    if (this.fileType != null) {
      json[r'fileType'] = this.fileType;
    } else {
      json[r'fileType'] = null;
    }
      json[r'id'] = this.id;
      json[r'imageData'] = this.imageData;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'receiptId'] = this.receiptId;
    if (this.size != null) {
      json[r'size'] = this.size;
    } else {
      json[r'size'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [FileData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FileData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FileData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FileData(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        fileType: mapValueOfType<String>(json, r'fileType'),
        id: mapValueOfType<int>(json, r'id')!,
        imageData: json[r'imageData'] is List
            ? (json[r'imageData'] as List).cast<int>()
            : const [],
        name: mapValueOfType<String>(json, r'name'),
        receiptId: mapValueOfType<int>(json, r'receiptId')!,
        size: mapValueOfType<int>(json, r'size'),
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
      );
    }
    return null;
  }

  static List<FileData>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileData> mapFromJson(dynamic json) {
    final map = <String, FileData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileData-objects as value to a dart map
  static Map<String, List<FileData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileData>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileData.listFromJson(entry.value, growable: growable,);
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
    'receiptId',
  };
}

