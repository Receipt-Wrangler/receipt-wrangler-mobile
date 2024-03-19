//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PagedDataDataInner {
  /// Returns a new [PagedDataDataInner] instance.
  PagedDataDataInner({
    required this.amount,
    this.categories = const [],
    this.comments = const [],
    this.createdAt,
    this.createdBy,
    required this.date,
    required this.groupId,
    required this.id,
    this.imageFiles = const [],
    required this.name,
    required this.paidByUserId,
    this.receiptItems = const [],
    this.resolvedDate,
    required this.status,
    this.tags = const [],
    this.updatedAt,
    this.createdByString,
    this.description,
  });

  /// Reciept total amount
  String amount;

  /// Categories associated to receipt
  List<Category> categories;

  /// Comments associated to receipt
  List<Comment> comments;

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

  /// Receipt date
  String date;

  /// Group foreign key
  int groupId;

  int id;

  /// Files associated to receipt
  List<FileData> imageFiles;

  /// Tag name
  String name;

  /// User paid foreign key
  int paidByUserId;

  /// Items associated to receipt
  List<Item> receiptItems;

  /// Date resolved
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? resolvedDate;

  ReceiptStatus status;

  /// Tags associated to receipt
  List<Tag> tags;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  /// Created by string, which is anything that is not a user
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdByString;

  /// Description of the category
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PagedDataDataInner &&
     other.amount == amount &&
     other.categories == categories &&
     other.comments == comments &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.date == date &&
     other.groupId == groupId &&
     other.id == id &&
     other.imageFiles == imageFiles &&
     other.name == name &&
     other.paidByUserId == paidByUserId &&
     other.receiptItems == receiptItems &&
     other.resolvedDate == resolvedDate &&
     other.status == status &&
     other.tags == tags &&
     other.updatedAt == updatedAt &&
     other.createdByString == createdByString &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (amount.hashCode) +
    (categories.hashCode) +
    (comments.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (date.hashCode) +
    (groupId.hashCode) +
    (id.hashCode) +
    (imageFiles.hashCode) +
    (name.hashCode) +
    (paidByUserId.hashCode) +
    (receiptItems.hashCode) +
    (resolvedDate == null ? 0 : resolvedDate!.hashCode) +
    (status.hashCode) +
    (tags.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (createdByString == null ? 0 : createdByString!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'PagedDataDataInner[amount=$amount, categories=$categories, comments=$comments, createdAt=$createdAt, createdBy=$createdBy, date=$date, groupId=$groupId, id=$id, imageFiles=$imageFiles, name=$name, paidByUserId=$paidByUserId, receiptItems=$receiptItems, resolvedDate=$resolvedDate, status=$status, tags=$tags, updatedAt=$updatedAt, createdByString=$createdByString, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'amount'] = this.amount;
      json[r'categories'] = this.categories;
      json[r'comments'] = this.comments;
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
      json[r'date'] = this.date;
      json[r'groupId'] = this.groupId;
      json[r'id'] = this.id;
      json[r'imageFiles'] = this.imageFiles;
      json[r'name'] = this.name;
      json[r'paidByUserId'] = this.paidByUserId;
      json[r'receiptItems'] = this.receiptItems;
    if (this.resolvedDate != null) {
      json[r'resolvedDate'] = this.resolvedDate;
    } else {
      json[r'resolvedDate'] = null;
    }
      json[r'status'] = this.status;
      json[r'tags'] = this.tags;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    if (this.createdByString != null) {
      json[r'createdByString'] = this.createdByString;
    } else {
      json[r'createdByString'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    return json;
  }

  /// Returns a new [PagedDataDataInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PagedDataDataInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PagedDataDataInner[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PagedDataDataInner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PagedDataDataInner(
        amount: mapValueOfType<String>(json, r'amount')!,
        categories: Category.listFromJson(json[r'categories']) ?? const [],
        comments: Comment.listFromJson(json[r'comments']) ?? const [],
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        date: mapValueOfType<String>(json, r'date')!,
        groupId: mapValueOfType<int>(json, r'groupId')!,
        id: mapValueOfType<int>(json, r'id')!,
        imageFiles: FileData.listFromJson(json[r'imageFiles']) ?? const [],
        name: mapValueOfType<String>(json, r'name')!,
        paidByUserId: mapValueOfType<int>(json, r'paidByUserId')!,
        receiptItems: Item.listFromJson(json[r'receiptItems']) ?? const [],
        resolvedDate: mapValueOfType<String>(json, r'resolvedDate'),
        status: ReceiptStatus.fromJson(json[r'status'])!,
        tags: Tag.listFromJson(json[r'tags']) ?? const [],
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        createdByString: mapValueOfType<String>(json, r'createdByString'),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<PagedDataDataInner>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PagedDataDataInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PagedDataDataInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PagedDataDataInner> mapFromJson(dynamic json) {
    final map = <String, PagedDataDataInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PagedDataDataInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PagedDataDataInner-objects as value to a dart map
  static Map<String, List<PagedDataDataInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PagedDataDataInner>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PagedDataDataInner.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'amount',
    'date',
    'groupId',
    'id',
    'name',
    'paidByUserId',
    'status',
  };
}

